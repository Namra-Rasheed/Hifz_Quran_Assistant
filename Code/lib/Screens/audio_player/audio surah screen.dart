import 'package:flutter/material.dart';

import '../../contant/contant.dart';

import '../../models/qari.dart';
import '../../models/surah.dart';
import '../../services/apiServices.dart';
import 'audio_screen.dart';


class AudioSurahScreen extends StatefulWidget {
  const AudioSurahScreen({Key? key,required this.qari}) : super(key: key);
  final Qari qari;


  @override
  _AudioSurahScreenState createState() => _AudioSurahScreenState();
}

class _AudioSurahScreenState extends State<AudioSurahScreen> {

  ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('Surah List',style: TextStyle(color: Colors.black,
              fontSize: 20,fontWeight: FontWeight.bold),),
        ),
        body:  FutureBuilder(
          future: apiServices.getSurah(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Surahs>> snapshot) {
            if (snapshot.hasData) {
              List<Surahs>? surah = snapshot.data;
              return ListView.builder(
                  itemCount: surah!.length,
                  itemBuilder: (context, index) =>
                      AudioTile(
                          surahName:snapshot.data![index].englishName,
                          totalAya: snapshot.data![index].numberOfAyahs,
                          number: snapshot.data![index].number,
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder:
                                (context)=>AudioScreen(
                              qari: widget.qari,
                              index: index+1,
                              list: surah,
                            )
                            ));
                          }));
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

Widget AudioTile({required String? surahName,required totalAya,
  required number ,required VoidCallback onTap}){

  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.green[50],
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 0,
                color: Colors.black12,
                offset: Offset(0,3),
              ),
            ]
        ),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 50,
              width: 50,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.lightGreen,
              ),
              child: Text((number).toString(),
                style: TextStyle(color:Colors.white ,fontSize: 12,fontWeight: FontWeight.bold),),
            ),
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  surahName!,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 3,),
                Text("Total Aya : $totalAya" ,style: TextStyle(color: Colors.black54,fontSize: 16),),
              ],
            ),
            Spacer(),
            Icon(Icons.play_circle_fill,color:Colors.lightGreen,),
          ],
        ),
      ),
    ),
  );
}