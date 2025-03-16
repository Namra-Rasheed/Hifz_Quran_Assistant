from flask import Flask, request, jsonify, send_file
from flask_cors import CORS
import tempfile
import os
import logging
from update import (
    QuranRecitationChecker, 
    read_surah_data_from_csv,
    highlight_mistakes,
    highlight_text_with_colors,
    generate_mistake_guidance
)
from gtts import gTTS

# Configure logging
logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

app = Flask(__name__)
CORS(app)

# Initialize the QuranRecitationChecker
try:
    checker = QuranRecitationChecker()
    logger.info("QuranRecitationChecker initialized successfully")
except Exception as e:
    logger.error(f"Failed to initialize QuranRecitationChecker: {str(e)}")
    raise

# Load Surah data at startup
try:
    SURAH_DATA = read_surah_data_from_csv("surahs.csv")
    logger.info(f"Loaded {len(SURAH_DATA)} surahs from CSV")
except Exception as e:
    logger.error(f"Failed to load surah data: {str(e)}")
    SURAH_DATA = []

def generate_tts_audio(text, language='ar'):
    """Generate TTS audio file from text."""
    try:
        tts = gTTS(text=text, lang=language, slow=False)
        temp_audio = tempfile.NamedTemporaryFile(delete=False, suffix=".wav")
        tts.save(temp_audio.name)
        return temp_audio.name  # Return the audio file path
    except Exception as e:
        logger.error(f"TTS generation failed: {str(e)}")
        return None

@app.route('/', methods=['GET'])
def home():
    """Root endpoint to verify API is running"""
    return jsonify({
        'status': 'success',
        'message': 'Quran Recitation API is running',
        'version': '1.0'
    })

@app.route('/api/surahs', methods=['GET'])
def get_surahs():
    """Get list of all available Surahs"""
    try:
        logger.debug("Fetching list of surahs")
        if not SURAH_DATA:
            return jsonify({'status': 'error', 'message': 'No surah data available'}), 500

        surahs = [{'id': surah['ID'], 'name': surah['Name']} for surah in SURAH_DATA]
        return jsonify({'status': 'success', 'data': surahs}), 200
    except Exception as e:
        logger.error(f"Error in get_surahs: {str(e)}")
        return jsonify({'status': 'error', 'message': str(e)}), 500

@app.route('/api/surah/<int:surah_id>', methods=['GET'])
def get_surah(surah_id):
    """Get details of a specific Surah"""
    try:
        logger.debug(f"Fetching surah with ID: {surah_id}")
        surah = next((s for s in SURAH_DATA if s['ID'] == surah_id), None)
        if not surah:
            return jsonify({'status': 'error', 'message': 'Surah not found'}), 404
            
        return jsonify({'status': 'success', 'data': {'id': surah['ID'], 'name': surah['Name'], 'text': surah['Text']}}), 200
    except Exception as e:
        logger.error(f"Error in get_surah: {str(e)}")
        return jsonify({'status': 'error', 'message': str(e)}), 500

@app.route('/api/check-recitation', methods=['POST'])
def check_recitation():
    """Check Quran recitation against correct text and provide TTS feedback."""
    try:
        if 'audio' not in request.files:
            return jsonify({'status': 'error', 'message': 'No audio file provided'}), 400

        surah_id = request.form.get('surah_id')
        surah = next((s for s in SURAH_DATA if s['ID'] == int(surah_id)), None)
        if not surah:
            return jsonify({'status': 'error', 'message': 'Invalid Surah ID'}), 400

        correct_text = surah['Text']
        audio_file = request.files['audio']

        with tempfile.NamedTemporaryFile(suffix='.wav', delete=False) as temp_file:
            audio_file.save(temp_file.name)
            audio_path = temp_file.name

        predicted_text = checker.predict(audio_path=audio_path)
        mistake_analysis = highlight_mistakes(predicted_text, correct_text)
        highlighted_text = highlight_text_with_colors(predicted_text, correct_text)

        # Generate mistake guidance and TTS for each correct word
        correct_words = correct_text.split()
        guidance_list = []
        all_guidance_text = []

        mistakes_with_audio = []
        for mistake in mistake_analysis['mistakes']:
            guidance = generate_mistake_guidance(mistake, correct_words)
            guidance_list.append(guidance)
            all_guidance_text.append(guidance)

            # Generate TTS for each correct word in the mistake
            correct_words_audio = []
            for word in mistake['correct_words']:
                word_audio_path = generate_tts_audio(word)
                if word_audio_path:
                    audio_url = f"/api/get-tts-audio?path={word_audio_path}"
                    correct_words_audio.append(audio_url)

            # Add the mistake with its audio URLs
            mistakes_with_audio.append({
                'correct_words': mistake['correct_words'],
                'predicted_words': mistake['predicted_words'],
                'similarity': mistake['similarity'],
                'correct_words_audio_urls': correct_words_audio
            })

        # Generate overall TTS audio for guidance
        guidance_text = " ".join(all_guidance_text) if all_guidance_text else "Your recitation is correct."
        tts_audio_path = generate_tts_audio(guidance_text)

        response_data = {
            'status': 'success',
            'data': {
                'predicted_text': predicted_text,
                'highlighted_text': highlighted_text,
                'accuracy_rate': mistake_analysis['accuracy_rate'],
                'mistakes': mistakes_with_audio,
                'guidance': guidance_list,
                'tts_audio_url': f"/api/get-tts-audio?path={tts_audio_path}" if tts_audio_path else None,
            }
        }
        return jsonify(response_data), 200

    except Exception as e:
        logger.error(f"Error in check_recitation: {str(e)}")
        return jsonify({'status': 'error', 'message': str(e)}), 500

@app.route('/api/get-tts-audio', methods=['GET'])
def get_tts_audio():
    """Serve the generated TTS audio file."""
    file_path = request.args.get('path')
    if file_path and os.path.exists(file_path):
        return send_file(file_path, mimetype="audio/mpeg")
    return jsonify({'status': 'error', 'message': 'Audio file not found'}), 404

@app.errorhandler(404)
def not_found_error(error):
    """Handle 404 errors."""
    return jsonify({'status': 'error', 'message': 'The requested URL was not found on the server'}), 404

@app.errorhandler(500)
def internal_error(error):
    """Handle 500 errors."""
    return jsonify({'status': 'error', 'message': 'An internal server error occurred'}), 500

if __name__ == '__main__':
    logger.info("Starting Flask server...")
    app.run(debug=True, host='0.0.0.0', port=5000)
