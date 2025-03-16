import 'dart:async';

import 'package:flutter/material.dart';
import '../Screens/Audioscreen.dart';
import 'recitation_model.dart';

import 'package:audioplayers/audioplayers.dart';

class RecitationResultScreen extends StatefulWidget {
  final Recitation recitation;

  const RecitationResultScreen({Key? key, required this.recitation}) : super(key: key);

  @override
  State<RecitationResultScreen> createState() => _RecitationResultScreenState();
}

class _RecitationResultScreenState extends State<RecitationResultScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int? _playingIndex;
  bool _isPlaying = false;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // Enhanced audio playback function with logging
  Future<void> _playAudio(String audioUrl, int index) async {
    try {
      print("Attempting to play audio from: $audioUrl");
      if (_isPlaying) {
        await _audioPlayer.stop();
      }

      setState(() {
        _playingIndex = index;
        _isPlaying = true;
      });

      final Uri fullUrl = Uri.parse('http://192.168.52.125:5000$audioUrl');
      print("Full URL: $fullUrl");

      await _audioPlayer.play(UrlSource(fullUrl.toString())).timeout(Duration(seconds: 60));

      print("Audio started playing...");

      _audioPlayer.onPlayerStateChanged.listen((state) {
        if (state == PlayerState.completed) {
          setState(() {
            _playingIndex = null;
            _isPlaying = false;
          });
        }
      });

    } catch (e) {
      print("Error: $e");
      setState(() {
        _playingIndex = null;
        _isPlaying = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e is TimeoutException
                ? 'Connection timed out. Please check your internet connection.'
                : 'Failed to play audio. Please try again.',
          ),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  // Play overall feedback TTS with logging
  Future<void> _playOverallFeedback() async {
    if (widget.recitation.data?.ttsAudioUrl != null) {
      try {
        print("TTS Audio URL: ${widget.recitation.data?.ttsAudioUrl}");
        await _playAudio(widget.recitation.data!.ttsAudioUrl!, -1);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to play feedback audio: $e')),
        );
      }
    } else {
      print("TTS Audio URL is null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recitation Result',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.lightGreen,
        actions: [
          // Add overall feedback audio button with logging
          if (widget.recitation.data?.ttsAudioUrl != null)
            IconButton(
              icon: Icon(
                _playingIndex == -1 ? Icons.pause_circle : Icons.play_circle,
                color: Colors.white,
              ),
              onPressed: () {
                print("Play TTS button clicked");
                _playOverallFeedback();
              },
              tooltip: 'Play overall feedback',
            ),
        ],
      ),
      backgroundColor: Colors.green[100],
      body: Padding(

        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Accuracy & Transcription Card
            SizedBox(
              width: double.infinity, // Makes the card take the full width
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                    children: [
                      Text(
                        "Accuracy: ${widget.recitation.data?.accuracyRate?.toStringAsFixed(1) ?? '0'}%",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Transcription:",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),

                      ),
                      const SizedBox(height: 5),
                      widget.recitation.data?.predictedText != null
                          ? buildHighlightedText(
                        widget.recitation.data!.predictedText!,
                        widget.recitation.data!.mistakes ?? [],
                      )
                          : Text("No transcription available"),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Mistakes List
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Mistakes",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                if (_isPlaying)
                  TextButton.icon(
                    icon: Icon(Icons.stop_circle, color: Colors.red),
                    label: Text('Stop Audio',style: TextStyle(color: Colors.black),),
                    onPressed: () async {
                      await _audioPlayer.stop();
                      setState(() {
                        _playingIndex = null;
                        _isPlaying = false;
                      });
                    },
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: widget.recitation.data?.mistakes != null &&
                  widget.recitation.data!.mistakes!.isNotEmpty
                  ? ListView.builder(
                itemCount: widget.recitation.data!.mistakes!.length,
                itemBuilder: (context, index) {
                  final mistake = widget.recitation.data!.mistakes![index];
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListTile(

                      title: Text(
                        "Correct: ${mistake.correctWords?.join(', ')}",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Predicted: ${mistake.predictedWords?.join(', ')}",
                              style: TextStyle(color: Colors.red)
                          ),
                          Text(
                              "Similarity: ${mistake.similarity?.toStringAsFixed(2)}%"
                          ),
                          if (mistake.correctWordsAudioUrls != null)
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: mistake.correctWordsAudioUrls!.asMap().entries.map((entry) {
                                  final wordIndex = entry.key;
                                  final audioUrl = entry.value;
                                  final isPlaying = _playingIndex == (index * 100 + wordIndex);

                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: ElevatedButton.icon(
                                      icon: Icon(
                                        isPlaying ? Icons.pause : Icons.volume_up,
                                        size: 20,
                                        color: isPlaying ? Colors.white : Colors.green.shade400,
                                      ),
                                      label: Text(
                                        mistake.correctWords?[wordIndex] ?? 'Word ${wordIndex + 1}',
                                        style: TextStyle(
                                          color: isPlaying ? Colors.white : Colors.black,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: isPlaying ? Colors.lightGreen : Colors.white,
                                        side: BorderSide(color: Colors.black),
                                      ),
                                      onPressed: () => _playAudio(
                                        audioUrl,
                                        index * 100 + wordIndex,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              )
                  : Center(
                child: Text(
                  "No mistakes found",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ),

            // OK Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AudioScreen()),
                  );
                },
                child: Text('OK',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHighlightedText(String predictedText, List<Mistakes> mistakes) {
    List<TextSpan> spans = [];
    List<String> words = predictedText.split(" ");
    Map<int, bool> mistakeMap = {}; // Maps word index to whether it's a mistake

    // Identify incorrect word indices
    for (var mistake in mistakes) {
      if (mistake.startIndex != null && mistake.predictedWords != null) {
        for (int i = 0; i < mistake.predictedWords!.length; i++) {
          mistakeMap[mistake.startIndex! + i] = true;
        }
      }
    }

    // Build the text with highlights
    for (int i = 0; i < words.length; i++) {
      spans.add(TextSpan(
        text: "${words[i]} ",
        style: TextStyle(
          color: mistakeMap.containsKey(i) ? Colors.black : Colors.red,
          fontWeight: mistakeMap.containsKey(i) ? FontWeight.bold : FontWeight.normal,
        ),
      ));
    }

    return RichText(
      text: TextSpan(
        children: spans,
        style: TextStyle(fontSize: 18),
      ),
    );
  }


}
