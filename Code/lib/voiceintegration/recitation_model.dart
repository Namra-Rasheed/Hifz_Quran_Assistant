class Recitation {
  Data? data;
  String? status;

  Recitation({this.data, this.status});

  Recitation.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  double? accuracyRate;
  List<String>? guidance;
  String? highlightedText;
  List<Mistakes>? mistakes;
  String? predictedText;
  String? ttsAudioUrl; // Overall feedback TTS

  Data({
    this.accuracyRate,
    this.guidance,
    this.highlightedText,
    this.mistakes,
    this.predictedText,
    this.ttsAudioUrl,
  });

  Data.fromJson(Map<String, dynamic> json) {
    accuracyRate = (json['accuracy_rate'] as num?)?.toDouble();
    guidance = json['guidance']?.cast<String>() ?? [];
    highlightedText = json['highlighted_text'] ?? "";
    if (json['mistakes'] != null) {
      mistakes = <Mistakes>[];
      json['mistakes'].forEach((v) {
        mistakes!.add(Mistakes.fromJson(v));
      });
    }
    predictedText = json['predicted_text'];
    ttsAudioUrl = json['tts_audio_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['accuracy_rate'] = this.accuracyRate;
    data['guidance'] = this.guidance;
    data['highlighted_text'] = this.highlightedText;
    if (this.mistakes != null) {
      data['mistakes'] = this.mistakes!.map((v) => v.toJson()).toList();
    }
    data['predicted_text'] = this.predictedText;
    data['tts_audio_url'] = this.ttsAudioUrl;
    return data;
  }
}

class Mistakes {
  List<String>? correctWords;
  List<String>? predictedWords;
  double? similarity;
  int? startIndex;
  String? type;
  List<String>? correctWordsAudioUrls; // Individual word TTS URLs

  Mistakes({
    this.correctWords,
    this.predictedWords,
    this.similarity,
    this.startIndex,
    this.type,
    this.correctWordsAudioUrls,
  });

  Mistakes.fromJson(Map<String, dynamic> json) {
    correctWords = json['correct_words']?.cast<String>();
    predictedWords = json['predicted_words']?.cast<String>();
    similarity = (json['similarity'] as num?)?.toDouble();
    startIndex = json['start_index'];
    type = json['type'];
    correctWordsAudioUrls = json['correct_words_audio_urls']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['correct_words'] = this.correctWords;
    data['predicted_words'] = this.predictedWords;
    data['similarity'] = this.similarity;
    data['start_index'] = this.startIndex;
    data['type'] = this.type;
    data['correct_words_audio_urls'] = this.correctWordsAudioUrls;
    return data;
  }
}