import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../models/ayaoftheday.dart';
import '../models/juzmodel.dart';
import '../models/translation.dart';
import '../models/qari.dart';
import '../models/surah.dart';


class ApiServices{

  final endPointUrl ="http://api.alquran.cloud/v1/surah";
  List<Surahs> list = [];

  Future<Ayatofday> getAyaOfTheDay() async {

    // for random Aya we need to generate random number
    // (1,6237) from 1 to 6236
    // Random Aya
    String url = "https://api.alquran.cloud/v1/ayah/${random(1,6237)}/editions/quran-uthmani,en.asad,en.pickthall";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Ayatofday.fromJSON(json.decode(response.body));
    } else {
      print("Failed to load");
      throw Exception("Failed  to Load Post");
    }
  }
  random(min, max){
    var rn = new Random();
    return min + rn.nextInt(max - min);
  }

  Future<List<Surahs>> getSurah() async{

    Response res = await http.get(Uri.parse(endPointUrl));
    if(res.statusCode == 200){
      Map<String,dynamic> json = jsonDecode(res.body);
      json['data'].forEach((element){
        if(list.length<114) {
          list.add(Surahs.fromJson(element));
        }
      });
      print('ol ${list.length}');
      return list;
    }else{
      throw ("Can't get the Surah");
    }
  }



  Future<JuzModel> getJuzz(int index) async {
    String url = "http://api.alquran.cloud/v1/juz/$index/quran-uthmani";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return JuzModel.fromJSON(json.decode(response.body));
    } else {
      print("Failed to load");
      throw Exception("Failed  to Load Post");
    }
  }

  Future<SurahTranslationList> getTranslation(int index , int translationIndex) async{

    String lan = "";
    if(translationIndex == 0){
      lan = "urdu_junagarhi";

    }else if(translationIndex == 1){
      lan = "english_saheeh";
    }

    final url = "https://quranenc.com/api/translation/sura/$lan/$index";
    var res = await http.get(Uri.parse(url));

    return SurahTranslationList.fromJson(json.decode(res.body));
  }


  List<Qari> qarilist = [];

  Future<List<Qari>> getQariList() async {

    final url = "https://quranicaudio.com/api/qaris";
    final res = await http.get(Uri.parse(url));

    jsonDecode(res.body).forEach((element){
      if(qarilist.length<20) // 20 is not mandatory , you can change it upto 157
        qarilist.add(Qari.fromjson(element));
    });
    qarilist.sort((a,b)=>a.name!.compareTo(b.name!)); // sort according to A B C
    return qarilist;
  }
}

