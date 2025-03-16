class Surahs{

  int? number;
  String? name;
  String? englishName;
  String? englishNameTranslation;
  int? numberOfAyahs;
  String? revelationType;

  Surahs({this.number, this.name, this.englishName, this.englishNameTranslation,
    this.numberOfAyahs, this.revelationType});

  factory  Surahs.fromJson(Map<String,dynamic> json){
    return Surahs(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      englishNameTranslation: json['englishNameTranslation'],
      numberOfAyahs: json['numberOfAyahs'],
      revelationType: json['revelationType'],
    );
  }
}