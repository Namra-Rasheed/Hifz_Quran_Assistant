import 'package:flutter/material.dart';
import '../Custom/surah_custem_tile.dart';
import '../contant/contant.dart';
import '../juz/juzscreen.dart';
import '../models/surah.dart';
import '../models/surahDetails.dart';
import '../services/apiServices.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  _QuranScreenState createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {

  ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Added
      initialIndex: 0,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.lightGreen,
            leading: Container(), // Removed arrow
            title: Text(
              'القرآن الكريم',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,// Correct styling
            ),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Text(
                  'Surah',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
                Text(
                  'Juz',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),// index - 2
              ],
            ),
          ),
          body:
          TabBarView(
            children:  <Widget>[

              FutureBuilder(
                future: apiServices.getSurah(),
                builder: (BuildContext context, AsyncSnapshot<List<Surahs>> snapshot) {
                  if (snapshot.hasData) {
                    List<Surahs>? surah = snapshot.data;
                    return ListView.builder(
                      itemCount: surah!.length,
                      itemBuilder: (context, index) => SurahCustomListTile(surah: surah[index],
                          context: context, ontap: (){
                            setState(() {
                              Constants.surahIndex = (index + 1);
                            });
                            Navigator.pushNamed(context, Surahdetail.id);
                          }),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                    itemCount: 30,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            Constants.juzIndex = (index + 1);
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => JuzScreen()),
                          );
                        },
                        child: Card(
                          elevation: 4,
                          color: Colors.green,
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
