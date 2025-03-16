#!/usr/bin/env python
# coding: utf-8

# In[1]:


#get_ipython().system('pip install transformers torch torchaudio sounddevice soundfile pyttsx3 gtts')


# In[2]:


#get_ipython().system('pip install pyarabic')


# In[3]:


from transformers import AutoTokenizer


tokenizer = AutoTokenizer.from_pretrained("tarteel-ai/whisper-base-ar-quran")


# In[4]:


import csv
import numpy as np
import sounddevice as sd
import soundfile as sf
import pyttsx3
from gtts import gTTS
import torch
import torchaudio
import time
from collections import deque
import os
import re
import tempfile
import io
import difflib
import scipy
from typing import Optional
from transformers import WhisperProcessor, WhisperForConditionalGeneration, WhisperConfig
from pyarabic.araby import (normalize_alef, normalize_hamza, normalize_ligature, strip_tashkeel)


# In[5]:


def read_surah_data_from_csv(file_path):
    """Read Surah data from CSV file and return as a list of dictionaries."""
    surah_data = []
    try:
        with open(file_path, mode='r', encoding='utf-8') as file:
            csv_reader = csv.DictReader(file)
            for row in csv_reader:
                surah_data.append({
                    "ID": int(row["ID"]),
                    "Name": row["Name"],
                    "Text": row["Text"]
                })
    except Exception as e:
        print(f"Error reading CSV file: {e}")
    return surah_data


# In[6]:


def highlight_text_with_colors(predicted, correct):
    """Highlight correct words in green and incorrect words in red."""
    normalized_predicted = normalize_arabic_text(predicted)
    normalized_correct = normalize_arabic_text(correct)
    predicted_words = predicted.split()
    correct_words = correct.split()
    normalized_predicted_words = normalized_predicted.split()
    normalized_correct_words = normalized_correct.split()
    
    highlighted_text = []

    for i in range(min(len(normalized_correct_words), len(normalized_predicted_words))):
        if normalized_correct_words[i] == normalized_predicted_words[i]:
            highlighted_text.append(f"\033[92m{predicted_words[i]}\033[0m")  # Green for correct
        else:
            highlighted_text.append(f"\033[91m{predicted_words[i]}\033[0m")  # Red for incorrect

    # Handle extra words
    if len(predicted_words) > len(correct_words):
        for word in predicted_words[len(correct_words):]:
            highlighted_text.append(f"\033[91m{word}\033[0m")  # Red for extra words

    highlighted_text_str = ' '.join(highlighted_text)
    return highlighted_text_str


# In[7]:


# Alternative method to handle normalization without pyarabic.numbers
def normalize_number(text):
    """A simple implementation to normalize Arabic numbers to Indian digits"""
    arabic_numbers = "٠١٢٣٤٥٦٧٨٩"
    western_numbers = "0123456789"
    trans = str.maketrans(arabic_numbers, western_numbers)
    return text.translate(trans)

# Helper functions for normalization and transliteration
arabic_to_english_transliteration = {
    'ا': 'a', 'ب': 'b', 'ت': 't', 'ث': 'th', 'ج': 'j', 'ح': 'h', 'خ': 'kh',
    'د': 'd', 'ذ': 'dh', 'ر': 'r', 'ز': 'z', 'س': 's', 'ش': 'sh', 'ص': 's',
    'ض': 'd', 'ط': 't', 'ظ': 'z', 'ع': 'e', 'غ': 'gh', 'ف': 'f', 'ق': 'q',
    'ك': 'k', 'ل': 'l', 'م': 'm', 'ن': 'n', 'ه': 'h', 'و': 'w', 'ي': 'y',
    'أ': 'a', 'إ': 'i', 'ء': "'", 'ة': 'h'
}

def transliterate_arabic(text):
    """Transliterates Arabic text to English using a mapping."""
    transliterated_text = "".join(arabic_to_english_transliteration.get(char, char) for char in text)
    return transliterated_text    

def normalize_arabic_text(text):
    """Normalize Arabic text using pyarabic."""
    if not text:
        return text
    text = normalize_alef(text)
    text = normalize_hamza(text)
    text = normalize_ligature(text)
    text = strip_tashkeel(text)  # Remove diacritics
    text = normalize_number(text)
    text = re.sub(r'[\u200b\u200c\u200d\u200e\u200f\u202a\u202b\u202c\u202d\u202e]', '', text)
    text = re.sub(r'\s+', ' ', text).strip()
    return text


# In[8]:


def tts_play(text, language='ar', slow=False, volume=1.0, output_device=None):
    """Unified Text-to-Speech function for both Arabic and English with advanced configuration."""
    try:
        if not text or not text.strip():
            raise ValueError("Input text cannot be empty")
        if language == 'ar':
            mp3_fp = io.BytesIO()
            tts = gTTS(text=text, lang=language, slow=slow)
            tts.write_to_fp(mp3_fp)
            mp3_fp.seek(0)
            audio_data, sample_rate = sf.read(mp3_fp)
            audio_data = audio_data * volume
            if output_device is not None:
                sd.default.device = output_device
            sd.play(audio_data, sample_rate)
            sd.wait()
        elif language == 'en':
            engine = pyttsx3.init()
            engine.say(text)
            engine.runAndWait()
        else:
            raise ValueError(f"Unsupported language: {language}")
    except Exception as error:
        print(f"TTS error: {error}")


# In[9]:


def reduce_noise_spectral_subtraction(audio_data, sample_rate, noise_duration=0.5, smoothing_window=100):
    """Reduce noise using spectral subtraction."""
    if len(audio_data) == 0:
        return audio_data
    n_fft = 2048
    hop_length = n_fft // 4
    smoothed_audio = np.convolve(audio_data, np.ones(smoothing_window) / smoothing_window, mode='same')
    noise_frames = int(noise_duration * sample_rate)
    if noise_frames >= len(audio_data):
        noise_frames = len(audio_data) // 4
    noise_segment = smoothed_audio[:noise_frames]
    noise_stft = np.mean(np.abs(scipy.signal.stft(noise_segment, fs=sample_rate, nperseg=n_fft, noverlap=hop_length)[2]), axis=-1)
    freqs, time, audio_stft = scipy.signal.stft(smoothed_audio, fs=sample_rate, nperseg=n_fft, noverlap=hop_length)
    denoised_stft = np.maximum(np.abs(audio_stft) - noise_stft[:, None], 0) * np.exp(1j * np.angle(audio_stft))
    _, denoised_audio = scipy.signal.istft(denoised_stft, fs=sample_rate, nperseg=n_fft, noverlap=hop_length)
    return denoised_audio


# In[10]:


def calculate_word_similarity(word1, word2):
    """Calculate similarity between two words using difflib."""
    return difflib.SequenceMatcher(None, word1, word2).ratio()

def highlight_mistakes(predicted, correct):
    """Comprehensively analyze differences between transcriptions with advanced similarity matching."""
    normalized_predicted = normalize_arabic_text(predicted)
    normalized_correct = normalize_arabic_text(correct)
    predicted_words = predicted.split()
    correct_words = correct.split()
    normalized_predicted_words = normalized_predicted.split()
    normalized_correct_words = normalized_correct.split()
    mistakes = []
    matching_words = 0
    total_words = len(correct_words)
    for i in range(min(len(normalized_correct_words), len(normalized_predicted_words))):
        similarity = calculate_word_similarity(normalized_correct_words[i], normalized_predicted_words[i])
        if similarity <= 0.7:  # Threshold for considering words different
            mistakes.append({
                "type": "replace",
                "start_index": i,
                "correct_words": [correct_words[i]],  # Original word form
                "predicted_words": [predicted_words[i]],  # Original word form
                "similarity": similarity
            })
        else:
            matching_words += 1
    if len(predicted_words) > len(correct_words):
        mistakes.append({
            "type": "insert",
            "start_index": len(correct_words) - 1,
            "correct_words": [],
            "predicted_words": predicted_words[len(correct_words):],
            "similarity": 0
        })
    elif len(correct_words) > len(predicted_words):
        mistakes.append({
            "type": "delete",
            "start_index": len(predicted_words) - 1,
            "correct_words": correct_words[len(predicted_words):],
            "predicted_words": [],
            "similarity": 0
        })
    error_rate = (total_words - matching_words) / total_words * 100 if total_words > 0 else 0
    accuracy_rate = (matching_words / total_words * 100) if total_words > 0 else 0
    return {
        "mistakes": mistakes,
        "error_rate": error_rate,
        "accuracy_rate": accuracy_rate,
        "total_words": total_words,
        "matching_words": matching_words
    }

def generate_mistake_guidance(mistake, correct_words):
    """Generate concise mistake guidance focusing only on corrections."""
    mistake_type = mistake['type']
    start_index = mistake['start_index']
    
    # For 'replace', 'insert', and 'delete' mistakes, only focus on the correct word
    if start_index == 0:
        guidance_templates = {
            'replace': f"Correct word: '{mistake['correct_words'][0]}'",
            'insert': f"Extra words: '{' '.join(mistake['predicted_words'])}'",
            'delete': f"Missing word: '{mistake['correct_words'][0]}'"
        }
    else:
        # Focus only on the correct word when a mistake occurs
        guidance_templates = {
            'replace': f"Correct word: '{mistake['correct_words'][0]}'",
            'insert': f"Extra words: '{' '.join(mistake['predicted_words'])}'",
            'delete': f"Missing word: '{mistake['correct_words'][0]}'"
        }
    
    return guidance_templates.get(mistake_type, "Unknown error")


# In[11]:


class QuranRecitationChecker:
    def __init__(self, checkpoint_dir="./quran_recitation_checkpoints"):
        """
        Initialize Quran Recitation Checker with the default base model.
        """
        self.device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
        print(f"Using device: {self.device}")
        self.checkpoint_dir = checkpoint_dir
        os.makedirs(self.checkpoint_dir, exist_ok=True)
        self.load_model()  # Always load the base model
        self.silence_duration = 2.5
        self.sample_rate = 16000
        self.audio_queue = deque(maxlen=int(self.silence_duration * self.sample_rate))
        self.recording = False
        self.audio_data = []
        self.audio_buffer = []
        self.debug = True
        self.last_rms = 0

    def load_model(self):
        """
        Load the default pretrained model 'tarteel-ai/whisper-base-ar-quran'.
        Ignores any custom model paths.
        """
        try:
            print("Loading the default base model: 'tarteel-ai/whisper-base-ar-quran'")
            config = WhisperConfig.from_pretrained("tarteel-ai/whisper-base-ar-quran")
            config.use_cache = False  # Disable caching for inference stability

            # Load processor and model directly from the pretrained base model
            self.processor = WhisperProcessor.from_pretrained("tarteel-ai/whisper-base-ar-quran")
            self.model = WhisperForConditionalGeneration.from_pretrained(
                "tarteel-ai/whisper-base-ar-quran",
                config=config
            ).to(self.device)

            self.model.eval()  # Set the model to evaluation mode
            torch.set_grad_enabled(False)  # Disable gradients for inference

            print("Base model loaded successfully!")
        except Exception as e:
            print(f"Error loading the base model: {e}")
            raise RuntimeError("Failed to load the base model. Check your environment and dependencies.")

    def save_audio(self, audio_data, sample_rate=16000, filename=None):
        """Save audio data to a file."""
        if filename is None:
            with tempfile.NamedTemporaryFile(suffix='.wav', delete=False) as temp_file:
                sf.write(temp_file.name, audio_data, sample_rate)
                return temp_file.name
        else:
            sf.write(filename, audio_data, sample_rate)
            return filename
    def record_audio(self):
        """Record audio until consistent silence is detected or max duration is reached."""
        self.recording = True
        self.audio_data = []
        self.audio_buffer = []  # Reset buffer at start
        silence_frames = 30  # Increased for better silence detection
        silence_counter = 0
        max_duration = 45  # Increased maximum duration
        start_time = time.time()
        print("Recording started... Speak clearly into the microphone.")

        def audio_callback(indata, frames, time_info, status):
            if status:
                print(f"Status: {status}")
            
            # Convert to mono if necessary
            if indata.shape[1] > 1:
                audio_chunk = indata.mean(axis=1)
            else:
                audio_chunk = indata.flatten()

            # Store in both queue and buffer
            self.audio_queue.extend(audio_chunk)
            self.audio_buffer.append(audio_chunk.copy())
            
            # Calculate and store RMS
            rms = np.sqrt(np.mean(audio_chunk**2))
            self.last_rms = rms
            
            if self.debug:
                print(f"RMS: {rms:.4f} | Buffer size: {len(self.audio_buffer)} chunks")

        try:
            # Configure and open the input stream
            with sd.InputStream(
                samplerate=self.sample_rate,
                channels=1,
                dtype=np.float32,
                blocksize=int(self.sample_rate * 0.1),  # 100ms chunks
                callback=audio_callback
            ) as stream:
                print("Listening... (Press Ctrl+C to stop)")
                
                while self.recording and (time.time() - start_time) < max_duration:
                    # Process the latest audio data
                    if len(self.audio_queue) >= self.audio_queue.maxlen:
                        rms = self.last_rms
                        
                        if rms < 0.005:  # Adjusted threshold
                            silence_counter += 1
                            if self.debug:
                                print(f"Silence counter: {silence_counter}/{silence_frames}")
                            
                            if silence_counter >= silence_frames:
                                print("Silence detected, stopping recording...")
                                break
                        else:
                            silence_counter = 0
                    
                    time.sleep(0.1)

        except Exception as e:
            print(f"Recording error: {e}")
            return None
        
        finally:
            # Combine all audio chunks
            if self.audio_buffer:
                combined_audio = np.concatenate(self.audio_buffer)
                if len(combined_audio) / self.sample_rate >= 1.0:  # Minimum 1 second
                    print(f"Recording completed. Duration: {len(combined_audio)/self.sample_rate:.2f} seconds")
                    return combined_audio
                else:
                    print("Recording too short.")
                    return None
            else:
                print("No audio data recorded.")
                return None
            
    def predict(self, audio_path=None, audio_data=None):
        """
        Predict text from audio using Whisper model with optimized transcription.

        Args:
            audio_path (str, optional): Path to audio file
            audio_data (numpy.ndarray, optional): Raw audio data

        Returns:
            str: Transcribed and normalized Arabic text
        """
        try:
            if not audio_path and audio_data is None:
                raise ValueError("Either audio_path or audio_data must be provided")

            # Load or process audio data
            if audio_path:
                if self.debug:
                    print(f"Loading audio from file: {audio_path}")
                waveform, sample_rate = torchaudio.load(audio_path)
            else:
                if self.debug:
                    print("Processing provided audio data")
                # Ensure audio_data is properly shaped and typed
                audio_data = np.array(audio_data, dtype=np.float32)
                if audio_data.ndim == 1:
                    audio_data = audio_data.reshape(1, -1)
                waveform = torch.from_numpy(audio_data)
                sample_rate = self.sample_rate

            # Debug information
            if self.debug:
                print(f"Waveform shape: {waveform.shape}")
                print(f"Sample rate: {sample_rate}")
                print(f"Audio duration: {waveform.shape[-1]/sample_rate:.2f} seconds")
                print(f"Max amplitude: {torch.max(torch.abs(waveform)).item():.4f}")

            # Resample if necessary
            if sample_rate != 16000:
                if self.debug:
                    print(f"Resampling from {sample_rate}Hz to 16000Hz")
                resampler = torchaudio.transforms.Resample(sample_rate, 16000)
                waveform = resampler(waveform)

            # Convert to mono if necessary
            if waveform.shape[0] > 1:
                if self.debug:
                    print("Converting stereo to mono")
                waveform = torch.mean(waveform, dim=0, keepdim=True)

            # Normalize audio if needed
            max_amplitude = torch.max(torch.abs(waveform))
            if max_amplitude > 1.0:
                if self.debug:
                    print(f"Normalizing audio (max amplitude was {max_amplitude:.4f})")
                waveform = waveform / max_amplitude

            # Apply noise reduction
            waveform_np = waveform.squeeze().numpy()
            if self.debug:
                print("Applying noise reduction")
            denoised_audio = reduce_noise_spectral_subtraction(waveform_np, 16000)
            denoised_waveform = torch.from_numpy(denoised_audio).unsqueeze(0)

            # Prepare inputs for the model
            if self.debug:
                print("Preparing model inputs")
            inputs = self.processor(
                denoised_waveform.squeeze().numpy(),
                sampling_rate=16000,
                return_tensors="pt",
                return_attention_mask=True,
                padding=True
            )

            # Move inputs to appropriate device
            input_features = inputs.input_features.to(self.device)
            attention_mask = inputs.attention_mask.to(self.device)

            # Configure generation parameters
            generation_config = {
                "max_length": 448,
                "num_beams": 5,
                "do_sample": True,
                "temperature": 0.2,
                "top_k": 50,
                "top_p": 0.95,
                "no_repeat_ngram_size": 2,
                "early_stopping": False
            }

            # Generate prediction
            if self.debug:
                print("Generating prediction")
            try:
                with torch.no_grad():
                    generated_ids = self.model.generate(
                        input_features,
                        attention_mask=attention_mask,
                        **generation_config
                    )

                # Decode prediction
                predicted_text = self.processor.decode(generated_ids[0], skip_special_tokens=True)

                if self.debug:
                    print(f"Raw prediction: {predicted_text}")

                # Normalize the predicted text
                normalized_text = normalize_arabic_text(predicted_text)

                if self.debug:
                    print(f"Normalized prediction: {normalized_text}")

                return normalized_text

            except RuntimeError as e:
                if "out of memory" in str(e):
                    if self.debug:
                        print("GPU out of memory, attempting to free cache")
                    if torch.cuda.is_available():
                        torch.cuda.empty_cache()
                    return self.predict(audio_path, audio_data)  # Retry once
                raise e

        except Exception as e:
            print(f"Error during prediction: {str(e)}")
            if self.debug:
                import traceback
                traceback.print_exc()
            return ""

    


# In[12]:


def main():
    """Main execution flow for Quran Recitation Checker."""
    try:
        # Initialize QuranRecitationChecker (no 'model_name' argument)
        checker = QuranRecitationChecker(checkpoint_dir="checkpoint-500")

        # Load the base model (custom loading removed)
        checker.load_model()

        # Ask the user whether they want to read or exit
        user_choice = input("Press 1 to read or 0 to exit: ").strip()
        if user_choice == '0':
            print("Exiting the program.")
            return  # Exit the program
        elif user_choice != '1':
            print("Invalid input. Please press 1 to read or 0 to exit.")
            return

        # Read Surah data from CSV file
        csv_file_path = "surahs.csv"  # Replace with the actual CSV file path
        surah_data = read_surah_data_from_csv(csv_file_path)
        if not surah_data:
            print("No Surah data found in CSV file.")
            return

        # Display Surah IDs and Names
        print("Available Surahs:")
        for surah in surah_data:
            print(f"ID: {surah['ID']}, Name: {surah['Name']}")

        # Ask user for Surah ID
        surah_id = int(input("Enter the Surah ID you want to read: ").strip())
        selected_surah = next((surah for surah in surah_data if surah["ID"] == surah_id), None)
        if not selected_surah:
            print("Invalid Surah ID. Please try again.")
            return

        correct_text = selected_surah["Text"]
        print(f"Please read the following Surah ({selected_surah['Name']}):")
        print(correct_text)

        # Record audio from the user
        audio_data = checker.record_audio()
        if audio_data is None:
            print("No audio recorded, please try again.")
            return

        # Save recorded audio to a temporary file
        audio_file = checker.save_audio(audio_data)

        # Run prediction
        predicted_text = checker.predict(audio_path=audio_file)

        mistake_analysis = highlight_mistakes(predicted_text, correct_text)

        # Split the correct text into words for guidance
        correct_words = correct_text.split()

        print("\n--- Recitation Analysis ---")
        highlighted_text = highlight_text_with_colors(predicted_text, correct_text)
        print(f"Your Recitation: {highlighted_text}")
        print(f"Expected Recitation: {correct_text}")

        if mistake_analysis['mistakes']:
            for mistake in mistake_analysis['mistakes']:
                guidance = generate_mistake_guidance(mistake, correct_words)
                print(guidance)
                tts_play(guidance, language='ar')  # TTS for mistake guidance
        else:
            print("Excellent recitation!")
            tts_play("Excellent recitation!", language='ar')

        print(f"Accuracy Rate: {mistake_analysis['accuracy_rate']}%")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    main()


# 

# In[ ]:




