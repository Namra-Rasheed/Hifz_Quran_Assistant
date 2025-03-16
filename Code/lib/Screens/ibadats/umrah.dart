import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UmrahScreen extends StatefulWidget {
  @override
  _UmrahScreenState createState() => _UmrahScreenState();
}

class _UmrahScreenState extends State<UmrahScreen> {
  // List to store bookmark states for each Umrah step
  List<bool> bookmarkStates = List.generate(4, (index) => false); // Adjust the number of steps

  @override
  void initState() {
    super.initState();
    _loadBookmarkStates();
  }

  // Load bookmark states from SharedPreferences
  void _loadBookmarkStates() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < bookmarkStates.length; i++) {
      setState(() {
        bookmarkStates[i] = prefs.getBool('umrah_bookmark_$i') ?? false;
      });
    }
  }

  // Save bookmark state to SharedPreferences
  void _saveBookmarkState(int index, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('umrah_bookmark_$index', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Umrah Guide',style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
      ),
      body: Container(
       color: Colors.lime[50],
        child: ListView(
          children: [
            _umrahTile(
              '1 نیت',
              'اَللّٰهُمَّ إِنِّي أُرِيدُ الْعُمْرَةَ فَيَسِّرْهَا لِيْ وَتَقَبَّلْهَا مِنِّيْ',
              'O ALLAH, I intend to perform Umrah, so make it easy for me and accept it from me.',
              'اے اللہ! میں عمرہ کرنے کا ارادہ کرتا ہوں، تو اسے میرے لئے آسان کر دے اور اسے مجھ سے قبول فرما۔',
              bookmarkStates[0],
                  (bool value) {
                setState(() {
                  bookmarkStates[0] = value;
                  _saveBookmarkState(0, value);
                });
              },
            ),
            _umrahTile(
              '2 طواف',
              'بِسْمِ اللّٰهِ وَاللّٰهُ أَكْبَرُ',
              'In the name of ALLAH, and ALLAH is the Greatest.',
              'اللہ کے نام سے، اور اللہ سب سے بڑا ہے۔',
              bookmarkStates[1],
                  (bool value) {
                setState(() {
                  bookmarkStates[1] = value;
                  _saveBookmarkState(1, value);
                });
              },
            ),
            _umrahTile(
              '3 سعی',
              'إِنَّ الصَّفَا وَالْمَرْوَةَ مِن شَعَائِرِ اللَّهِ',
              'Indeed Safa and Marwah are among the symbols of ALLAH.',
              'بیشک صفا اور مروہ اللہ کی نشانیوں میں سے ہیں۔',
              bookmarkStates[2],
                  (bool value) {
                setState(() {
                  bookmarkStates[2] = value;
                  _saveBookmarkState(2, value);
                });
              },
            ),
            _umrahTile(
              '4 حلق یا تقصیر',
              'اَللّٰهُمَّ تَقَبَّلْ مِنَّا',
              'O ALLAH, accept this from us.',
              'اے اللہ! اسے ہم سے قبول فرما۔',
              bookmarkStates[3],
                  (bool value) {
                setState(() {
                  bookmarkStates[3] = value;
                  _saveBookmarkState(3, value);
                });
              },
            ),
          ],
        ),
      ),

    );
  }

  Widget _umrahTile(
      String title,
      String arabicText,
      String englishTranslation,
      String urduTranslation,
      bool isBookmarked,
      Function(bool) onBookmarkChanged) {
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
        leading: IconButton(
          icon: Icon(
            isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            color: isBookmarked ? Colors.green : Colors.green, // Change color when bookmarked
          ),
          onPressed: () {
            onBookmarkChanged(!isBookmarked); // Toggle bookmark state
          },
        ),
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
