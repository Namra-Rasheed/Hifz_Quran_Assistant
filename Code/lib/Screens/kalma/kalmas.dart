import 'package:flutter/material.dart';

class KalmasScreen extends StatefulWidget {
  @override
  _KalmasScreenState createState() => _KalmasScreenState();
}

class _KalmasScreenState extends State<KalmasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('6 Kalmas',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _kalmaTile(
              '1 کلمہ',
              'لَا إِلَٰهَ إِلَّا ٱللَّٰهُ مُحَمَّدٌ رَسُولُ ٱللَّٰهِ',
              'There is none worthy of worship except ALLAH, (and) Muhammad (P.B.U.H) is the Messenger of ALLAH..',
              'اللہ کے سوا کوئی معبود نہیں محمّدؐ اللہ کے رسول ہیں'
          ),  // Kalma 1
          _kalmaTile(
              '2 کلمہ',
              'اَشْهَدُ اَنْ لَّآ اِلٰهَ اِلَّا اللهُ وَحْدَہٗ لَاشَرِيْكَ لَہٗ وَاَشْهَدُ اَنَّ مُحَمَّدًا عَبْدُهٗ وَرَسُولُہٗ',
              'I bear witness that there is none worthy of worship except ALLAH, the One alone, without partner, and I bear witness that Muhammad (P.B.U.H) is His Servant and Messenger..',
              'میں گواہی دیتا ہوں کہ اللہ کے سوا کوئی معبود نہیں وہ اکیلا ہے اسکا کوئی شریک نہیں اور میں گواہی دیتا ہوں کہ محمد ﷺ اسکے بندے اور رسول ہیں.'
          ),  // Kalma 2
          _kalmaTile(
              '3 کلمہ',
              'سُبْحَان اللهِ وَالْحَمْدُلِلّهِ وَلا إِلهَ إِلّااللّهُ وَاللّهُ أكْبَرُ وَلا حَوْلَ وَلاَ قُوَّةَ إِلَّا بِاللّهِ الْعَلِيِّ الْعَظِيْم',
              'Glory be to ALLAH and all praise be to ALLAH and there is none worthy of worship except ALLAH, and ALLAH is the Greatest. And there is no might or power except with ALLAH, the Exalted, the Great One..',
              'اللہ کی ذات پاک ہے اور سب تعریفیں اللہ کیلئے ہیں اور اللہ کے سوا کوئی معبود نہیں اور اللہ بہت بڑا ہے اور گناہوں سے بچنے کی طاقت اور نیک کام کرنے کی توفیق اللہ کی جانب سے ہے جو بہت بلند اور عظمت والا ہے.'
          ),  // Kalma 3
          _kalmaTile(
              '4 کلمہ',
              'لَآ اِلٰهَ اِلَّا اللهُ وَحْدَهٗ لَا شَرِيْكَ لَهٗ لَهُ الْمُلْكُ وَ لَهُ الْحَمْدُ يُحْىٖ وَ يُمِيْتُ وَ هُوَحَیٌّ لَّا يَمُوْتُ اَبَدًا اَبَدًاؕ ذُو الْجَلَالِ وَالْاِكْرَامِؕ بِيَدِهِ الْخَيْرُؕ وَهُوَ عَلٰى كُلِّ شیْ ٍٔ قَدِیْرٌؕ',
              'There is none worthy of worship except ALLAH. He is alone and has no partner. To Him belongs the Kingdom and for Him is all praise. He gives life and causes death. And He is alive. He will not die, never, ever. Possessor of Majesty and Reverence. In His hand is all good and He has power over everything.',
              'اللہ کے سوا کوئی معبود نہیں وہ اکیلا ہے اسکا کوئی شریک نہیں، اسی کی بادشاہی ہے اور اس کے لیے تمام تعریفیں ہیں۔ وہ زندہ کرتا ہے اور وہی مارتا ہے۔ اور وہ ہمیشہ کیلئے زندہ ہے وہ مرے گا نہیں، وہی عظمت اور بزرگی والا ہے ، بہتری اسی کے ہاتھ میں ہے اور وہ ہر چیز پر قادر ہے.'
          ),  // Kalma 4
          _kalmaTile(
              '5 کلمہ',
              'اَسْتَغْفِرُ اللهِ رَبِّىْ مِنْ كُلِِّ ذَنْۢبٍ اَذْنَبْتُهٗ عَمَدًا اَوْ خَطَا ًٔ سِرًّا اَوْ عَلَانِيَةً وَّاَتُوْبُ اِلَيْهِ مِنَ الذَّنْۢبِ الَّذِیْٓ اَعْلَمُ وَ مِنَالذَّنْۢبِ الَّذِىْ لَآ اَعْلَمُ اِنَّكَ اَنْتَ عَلَّامُ الْغُيُوْبِ وَ سَتَّارُ الْعُيُوْبِ و َغَفَّارُ الذُّنُوْبِ وَ لَا حَوْلَ وَلَا قُوَّةَ اِلَّا بِاللهِ الْعَلِىِِّ الْعَظِيْمِؕ ',
              'I seek forgiveness from ALLAH, my Lord, from every sin I committed knowingly or unknowingly, secretly or openly, and I turn towards Him from the sin that I know and from the sin that I do not know, Certainly You (O ALLAH!), You (are) the knower of the hidden things and the Concealer (of) the mistakes and the Forgiver (of) the sins. And (there is) no power and no strength except from ALLAH, the Most High, the Most Great..',
              'معافی مانگتا ہوں اے میرے اللہ ہر گناہ سے جو میں نے جان بوجھ کر کیا ہے یا بھول کر کیا ہے ،در پردہ یا کھلم کھلا اور میں توبہ کرتا ہوں اسکے حضور میں اس گناہ سے جو مجھے معلوم ہے اور اس گناہ سے جو مجھے معلوم نہیں،بے شک تو عیبوں کو جاننے والا اور عیبوں کو چھپانے والا ہے، اور گناہوں سے بخشنے والا ہے اور گناہوں سے بچنے کی طاقت اور نیک کام کرنے کی طاقت اللہ ہی کی طرف سے ہے۔ جو شان اور عظمت والا ہے.'
          ),  // Kalma 5
          _kalmaTile(
              '6 کلمہ',
              'اَللّٰهُمَّ اِنِّیْٓ اَعُوْذُ بِكَ مِنْ اَنْ اُشْرِكَ بِكَ شَيْئًا وَّاَنَآ اَعْلَمُ بِهٖ وَ اَسْتَغْفِرُكَ لِمَا لَآ اَعْلَمُ بِهٖ تُبْتُ عَنْهُ وَ تَبَرَّأْتُ مِنَ الْكُفْرِ وَ الشِّرْكِ وَ الْكِذْبِ وَ الْغِيْبَةِ وَ الْبِدْعَةِ وَ النَّمِيْمَةِ وَ الْفَوَاحِشِ وَ الْبُهْتَانِ وَ الْمَعَاصِىْ كُلِِّهَا وَ اَسْلَمْتُ وَ اَقُوْلُ لَآ اِلٰهَ اِلَّا اللهُ مُحَمَّدٌ رَّسُوْلُ اللهِؕ',
              'O ALLAH! I seek refuge in You from that I should not join any partner with You and I have knowledge of it. I seek Your forgiveness from that which I do not know. I repent from it (ignorance) and I reject disbelief and joining partners with You and of falsehood and slandering and innovation in religion and tell-tales and evil deeds and the blame and the disobedience, all of them. I submit to Your will and I believe and declare: There is none worthy of worship except ALLAH and Muhammad (P.B.U.H) is His Messenger..',
              'آے اللہ میں پناہ مانگتا ہوں اس بات سے کہ میں کسی شے کو تیرا شریک بناوں جان بوجھ کر،اور بخشش مانگتا ہوں میں تجھ سے اس شرک کی جو میں جانتا نہیں ہوں اور میں نے اس سے توبہ کی اور بیزار ہوا کفر سے، شرک سے، اور جھوٹ سے، اور غیبت سے، اور بدعت سے ، اور چغلی سے ، اور بے حیائی سے، اور بہتان سے اور تمام گناہوں سے اور میں اسلام لایا اور میں کہتا ہوں کہ اللہ کے سوا کوئی معبود نہیں اور محمد ﷺ اللہ کے رسول ہیں.'
          ),  // Kalma 6
        ],
      ),
    );
  }

  // Function to create each Kalma with decorative side box, text styling, and translations in Arabic, Urdu, and English
  Widget _kalmaTile(String title, String kalmaText, String englishTranslation, String urduTranslation) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 2), // Using green border for a more Islamic theme
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        color: Colors.white, // Adding a white background to each card
      ),
      child: ExpansionTile(
        leading: Icon(Icons.library_books, color: Colors.green), // Icon for each Kalma
        title: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'Times New Roman',  // Elegant font style
              color: Colors.green, // Green color for titles
            ),
          ),
        ),
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
              color: Colors.lightGreen[50], // Subtle background color for Kalma text
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Kalma Text (Arabic)
                Text(
                  kalmaText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Serif',  // Elegant font style for Kalma text
                    fontWeight: FontWeight.w400,
                    color: Colors.black, // Keep the Kalma text in black
                  ),
                ),
                SizedBox(height: 10), // Spacer between Kalma and Translations

                // English Translation
                Text(
                  englishTranslation,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Serif', // Elegant font style for translation text
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.7), // Slightly faded translation text
                  ),
                ),
                SizedBox(height: 10), // Spacer between English and Urdu translations

                // Urdu Translation
                Text(
                  urduTranslation,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Serif', // Elegant font style for translation text
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.7), // Slightly faded translation text
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
