import 'package:flutter/material.dart';

class Ayatofday{
  late final String? arText;
  late final String? enTran;
  late final String? surEnName;
  late final int? surNumber;

  Ayatofday({this.arText,this.enTran,this.surEnName,this.surNumber});

  factory Ayatofday.fromJSON(Map<String , dynamic> json){

    return Ayatofday(
      arText: json['data'][0]['text'],
      enTran: json['data'][2]['text'],
      surEnName: json['data'][2]['surah']['englishName'],
      surNumber: json['data'][2]['numberInSurah'],
    );
  }


}

