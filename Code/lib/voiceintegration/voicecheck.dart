import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'record_report.dart';
import 'resultscreen.dart';
import 'surah.dart';

class RecordAndUploadScreen extends StatefulWidget {
  final Surah surah;

  const RecordAndUploadScreen({Key? key, required this.surah}) : super(key: key);

  @override
  _RecordAndUploadScreenState createState() => _RecordAndUploadScreenState();
}

class _RecordAndUploadScreenState extends State<RecordAndUploadScreen> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final TextEditingController _surahIdController = TextEditingController();
  final TextEditingController _surahNameController = TextEditingController();
  bool _isRecording = false;
  File? _audioFile;

  @override
  void initState() {
    super.initState();
    _initializeRecorder();
    _surahIdController.text = widget.surah.id.toString();
    _surahNameController.text = widget.surah.name;
  }

  Future<void> _initializeRecorder() async {
    await Permission.microphone.request();
    await _recorder.openRecorder();
  }

  Future<void> _startRecording() async {
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/recorded_audio.wav';
    await _recorder.startRecorder(toFile: filePath);
    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopRecording() async {
    final filePath = await _recorder.stopRecorder();
    setState(() {
      _isRecording = false;
      _audioFile = File(filePath!);
    });
  }

  Future<void> _uploadAudio() async {
    if (_audioFile == null || !_audioFile!.existsSync()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please record a valid audio file")),
      );
      return;
    }

    final recitation = await ApiService.uploadAudio(_surahIdController.text, _audioFile!);

    if (recitation != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Audio uploaded successfully!")),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecitationResultScreen(recitation: recitation),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to upload audio")),
      );
    }
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record and Upload',style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.lightGreen,
      ),
      body: Container(
        decoration:  BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade100,Colors.green.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(

                  controller: _surahNameController,
                  decoration: InputDecoration(
                    labelText: 'Surah Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    prefixIcon: Icon(Icons.book, color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _surahIdController,
                  decoration: InputDecoration(
                    labelText: 'Surah ID',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    prefixIcon: Icon(Icons.confirmation_number, color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _isRecording ? _stopRecording : _startRecording,
                  icon: Icon(_isRecording ? Icons.stop : Icons.mic,color: Colors.white,),
                  label: Text(_isRecording ? 'Stop Recording' : 'Start Recording',style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isRecording ? Colors.red[400] : Colors.green[600],
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _uploadAudio,
                  icon: const Icon(Icons.upload,color: Colors.white,),
                  label: const Text('Upload Audio',style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}