class Surah {
  final int id;
  final String name;

  Surah({required this.id, required this.name});

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      id: json['id'],
      name: json['name'],
    );
  }
}