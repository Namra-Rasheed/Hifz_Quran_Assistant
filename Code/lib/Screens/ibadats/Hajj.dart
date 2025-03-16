import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class HajjScreen extends StatefulWidget {
  @override
  _HajjScreenState createState() => _HajjScreenState();
}

class _HajjScreenState extends State<HajjScreen> {
  // List to store the bookmark states for each tile
  List<bool> bookmarkStates = List.generate(10, (index) => false);

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  // Load the bookmark states from SharedPreferences
  Future<void> _loadBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < bookmarkStates.length; i++) {
      bookmarkStates[i] = prefs.getBool('bookmark_$i') ?? false;
    }
    setState(() {});
  }

  // Save the bookmark state to SharedPreferences
  Future<void> _saveBookmark(int index, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('bookmark_$index', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hajj Guide', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.lime[50],
        child: ListView(
          children: List.generate(10, (index) {
            // Define Hajj-related information for each step
            List<Map<String, String>> hajjSteps = [
              {
                'title': '1 نیت',
                'arabicText': 'اَللّٰهُمَّ إِنِّي أُرِيدُ الْحَجَّ فَيَسِّرْهُ لِيْ وَتَقَبَّلْهُ مِنِّيْ',
                'englishTranslation': 'O ALLAH, I intend to perform Hajj, so make it easy for me and accept it from me.',
                'urduTranslation': 'اے اللہ! میں حج کرنے کا ارادہ کرتا ہوں، تو اسے میرے لئے آسان کر دے اور اسے مجھ سے قبول فرما۔'
              },
              {
                'title': '2 طواف',
                'arabicText': 'بِسْمِ اللّٰهِ وَاللّٰهُ أَكْبَرُ',
                'englishTranslation': 'In the name of ALLAH, and ALLAH is the Greatest.',
                'urduTranslation': 'اللہ کے نام سے، اور اللہ سب سے بڑا ہے۔'
              },
              {
                'title': '3 سعی',
                'arabicText': 'اَللّهُمَّ اجْعَلْهُ خَيْرًا لِي',
                'englishTranslation': 'O Allah, make it better for me.',
                'urduTranslation': 'اے اللہ! اسے میرے لئے بہتر بنا۔'
              },
              {
                'title': '4 رمی جمار',
                'arabicText': 'بِسْمِ اللّهِ وَاللّهُ أَكْبَرُ',
                'englishTranslation': 'In the name of ALLAH, and ALLAH is the Greatest.',
                'urduTranslation': 'اللہ کے نام سے، اور اللہ سب سے بڑا ہے۔'
              },
              {
                'title': '5 قربانی',
                'arabicText': 'اللّهُمَّ تقبّل منّي',
                'englishTranslation': 'O Allah, accept from me.',
                'urduTranslation': 'اے اللہ! میرے سے قبول فرما۔'
              },
              {
                'title': '6 حلق',
                'arabicText': 'اللّهُمَّ اجْعَلْهُ لِي حَجًّا مَقْبُولًا',
                'englishTranslation': 'O Allah, make it an accepted Hajj for me.',
                'urduTranslation': 'اے اللہ! اسے میرے لئے قبول شدہ حج بنا۔'
              },
              {
                'title': '7 طواف افاضہ',
                'arabicText': 'بِسْمِ اللّهِ وَاللّهُ أَكْبَرُ',
                'englishTranslation': 'In the name of ALLAH, and ALLAH is the Greatest.',
                'urduTranslation': 'اللہ کے نام سے، اور اللہ سب سے بڑا ہے۔'
              },
              {
                'title': '8 طواف وداع',
                'arabicText': 'اللّهُمَّ اجْعَلْهُ خَيْرًا لِي',
                'englishTranslation': 'O Allah, make it better for me.',
                'urduTranslation': 'اے اللہ! اسے میرے لئے بہتر بنا۔'
              },
              {
                'title': '9 وقوف عرفات',
                'arabicText': 'اللّهُمَّ اجْعَلْهُ حَجًّا مَقْبُولًا',
                'englishTranslation': 'O Allah, make it an accepted Hajj for me.',
                'urduTranslation': 'اے اللہ! اسے میرے لئے قبول شدہ حج بنا۔'
              },
              {
                'title': '10 رمی جمار',
                'arabicText': 'بِسْمِ اللّهِ وَاللّهُ أَكْبَرُ',
                'englishTranslation': 'In the name of ALLAH, and ALLAH is the Greatest.',
                'urduTranslation': 'اللہ کے نام سے، اور اللہ سب سے بڑا ہے۔'
              },
            ];

            return _HajjTile(
              title: hajjSteps[index]['title']!,
              arabicText: hajjSteps[index]['arabicText']!,
              englishTranslation: hajjSteps[index]['englishTranslation']!,
              urduTranslation: hajjSteps[index]['urduTranslation']!,
              isBookmarked: bookmarkStates[index],
              onBookmarkChanged: (bool value) {
                setState(() {
                  bookmarkStates[index] = value;
                });
                _saveBookmark(index, value);
              },
            );
          }),
        ),
      ),
    );
  }

  // Save the bookmark state to SharedPreferences
  Future<void> saveBookmark(int index, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('bookmark_$index', value);
  }
}

class _HajjTile extends StatefulWidget {
  final String title;
  final String arabicText;
  final String englishTranslation;
  final String urduTranslation;
  final bool isBookmarked;
  final Function(bool) onBookmarkChanged;

  _HajjTile({
    required this.title,
    required this.arabicText,
    required this.englishTranslation,
    required this.urduTranslation,
    required this.isBookmarked,
    required this.onBookmarkChanged,
  });

  @override
  _HajjTileState createState() => _HajjTileState();
}

class _HajjTileState extends State<_HajjTile> {
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
        leading: IconButton(
          icon: Icon(
            widget.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            color: widget.isBookmarked ? Colors.green : Colors.green,
          ),
          onPressed: () {
            widget.onBookmarkChanged(!widget.isBookmarked);
          },
        ),
        title: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          child: Text(
            widget.title,
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
                  widget.arabicText,
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
                  widget.englishTranslation,
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
                  widget.urduTranslation,
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
