import 'package:flutter/material.dart';


class NamaazScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Namaaz-e-Janaza ', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.lime[50],
        child: ListView(
          children: [
            _NamaazTile(
              title: '1 Janaza Prayer for Male',
              arabicText: 'اَللّٰهُـمَّ اغۡفِـرۡ لَهُ وَارۡحَمۡـهُ',
              englishTranslation: 'O Allah, forgive him and have mercy on him.',
              urduTranslation: 'اے اللہ! اس کے لئے مغفرت اور رحمت عطا فرمائیے۔',
            ),
            _NamaazTile(
              title: '2 Janaza Prayer for Female',
              arabicText: 'اللهم اغفر لها وارحمه',
              englishTranslation: 'O Allah, forgive her and have mercy on her.',
              urduTranslation: 'اے اللہ! اس کے لئے مغفرت اور رحمت عطا فرمائیے۔',
            ),
            _NamaazTile(
              title: '3 Janaza Prayer for Child',
              arabicText: 'اللهم اجعلها من أهل الجنة',
              englishTranslation: 'O Allah, make him/her from the people of Paradise.',
              urduTranslation: 'اے اللہ! اسے جنت والوں میں شامل کر۔',
            ),
          ],
        ),
      ),
    );
  }
}

class _NamaazTile extends StatelessWidget {
  final String title;
  final String arabicText;
  final String englishTranslation;
  final String urduTranslation;

  _NamaazTile({
    required this.title,
    required this.arabicText,
    required this.englishTranslation,
    required this.urduTranslation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 2),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        color: Colors.white,
      ),
      child: ExpansionTile(
        title: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'Times New Roman',
              color: Colors.green,
            ),
          ),
        ),
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
              color: Colors.lightGreen[50],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  arabicText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Serif',
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  englishTranslation,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Serif',
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  urduTranslation,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Serif',
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
