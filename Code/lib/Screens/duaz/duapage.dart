import 'package:flutter/material.dart';

class DuasScreen extends StatelessWidget {
  final List<Map<String, String>> duasList = [
    {"title": "بِسْمِ اللَّهِ وَعَلَى بَرَكَةِ اللَّهِ", "content": "کھانے سے پہلے کی دعا"},
    {"title": "اَلْحَمْدُ لِلّٰہِ الَّذِیْ اَطْعَمَنَا وَسَقَانَاوَجَعَلَنَامُسْلِمِیْنَ ۔", "content": " کھانے کے بعد کی دعا"},

    {"title": "بِسْمِ اللّٰہِ اَوَّلَہ وَاٰخِرَہ۔", "content": "کھانے کے شروع میں بسم اللہ پڑھنا بھول جائے"},
    {"title": "اَللّٰھُمَّ بَارِکْ لَنَافِیْہِ وَزِدْنَامِنْہُ۔", "content": "دودھ پینے کے بعدکی دعاء"},
    {"title": "اللَّهُمَّ إِنِّي أَسْأَلُكَ عِلْمَاً نَافِعَاًً وَرِزْقَاً وَاسِعَاًَ وَشِفَاءً مِنْ كُلِّ دَاءٍ", "content": "آب زم زم پیتے وقت کی دع"},
    {"title": "اَلْحَمْدُ لِلّٰہِ الَّذِیْ کَسَانِیْ ھٰذَا وَرَزَقَنِیْہِ مِنْ غَیْرِ حَوْلٍ مِّنِّیْ وَلَاقُوَّةٍ-", "content": "کپڑے پہننے کی دعا"},
    {"title": "اَلْحَمْدُ لِلّٰہِ الَّذِیْ کَسَانِیْ مَآاُوَارِیْ بِہ عَوْرَتِیْ وَاَتَجَمَّلُ بِہ فِیْ حَیَاتِیْ ۔", "content": "جب نیا لباس پہنے تو یہ دعا"},
    {"title": "بِسْمِ اللّٰہِ تَوَکَّلْتُ عَلَی اللّٰہِ لَاحَوْلَ وَلَاقُوَّةَ اِلَّابِاللّٰہِ۔", "content": "گھر سے نکلنے کی دعا"},
    {"title": "للّٰھُمَّ اِنِّیْ اَسْئَلُکَ خَیْرَالْمَوْلِجِ وَخَیْرَالْمَخْرَجِ بِسْمِ اللّٰہِ وَلَجْنَا وَبِسْمِ اللّٰہِ خَرَجْنَا وَعَلَی اللّٰہِ رَبِّنَا تَوَکَّلْنَا ۔", "content": "گھر میں داخل ہونے کی دعا"},
    {"title": "اَللّٰہُمَّ اِنِّیْ اَعُوْذُبِکَ مِنَ الْخُبُثِ وَالْخَبَآئِثِ۔", "content": "بیت الخلاء میں داخل ہونے سے پہلے کی دعا"},
    {"title": "اَلْحَمْدُ لِلّٰہِ الَّذِیْ اَذْھَبَ عَنِّی الْاَذٰی وَعَافَانِیْْ ۔", "content": "ُبیت الخلاء سے باہر آنے کے بعد کی دعا"},

    {"title": "الْحَمْدُ لِلَّهِ۔", "content": "چھینک آنے کے وقت کی دعا"},
    {"title": "اَسْأَلُ اللّٰہَ الْعَظِیْمَ رَبَّ الْعَرْشِ الْعَظِیْمِ اَنْ یَّشْفِیَکَ۔ُ۔", "content": " مریض کی شفایابی کی دعا"},
    {"title": "َبِسْمِ اللَّهِ الْكَبِيرِ أَعُوذُ بِاللَّهِ الْعَظِيمِ مِنْ شَرِّ كُلِّ عَرَقٍ نَعَّارٍ وَمِنْ شَرِّ حَرِّ النَّارِ", "content": "درد اور بخار کی دعا"},
    {"title": " ّاللَّهُمَّ مَتِّعْنِي بِبَصَرِي وَاجْعَلْهُ الْوَارِثَ مِنِّي وَأَرِنِي فِي الْعَدُوِّ ثَأْرِي وَانْصُرْنِي عَلَى مَنْ ظَلَمَنِي", "content": "آنکھ میں درد کی دعا"},
    {"title": "لَابَأْسَ طُہُوْر اِنْ شَآ ئَ اللّٰہ۔۔", "content": "مریض کی عیادت کی دعا"},
    {"title": "َّأَذْهِبِ الْبَأْسَ رَبَّ النَّاسِ اشْفِ أَنْتَ الشَّافِي لَا شَافِيَ إِلَّا أَنْتَ۔", "content": "جلنے کے بعد کی دعا"},

    {"title": "اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ عَبْدِكَ وَرَسُولِكَ وَعَلَى الْمُؤْمِنِينَ وَالْمُؤْمِنَاتِ وَعَلَى الْمُسْلِمِينَ وَالْمُسْلِمَاتِِ۔", "content": "رزق میں برکت کی دعا"},
    {"title": "۔بِسْمِ اللّٰہِ الرَّحْمٰنِ الرَّحِیْمِ۔", "content": "وضو ٔ شروع کرنے کی دعا"},
    {"title": "اَشْھَدُاَنْ لَّا اِلٰہَ اِلَّا اللّٰہُ وَحْدَہ لَاشَرِیْکَ لَہ وَاَشْھَدُ اَ نَّ مُحَمَّدًا عَبْدُہ وَرَسُوْلُہ اَللّٰہُمَّ اجْعَلْنِیْ مِنَ التَّوَّابِیْنَ وَاجْعَلْنِیْ مِنَ الْمُتَطَھِّرِیْنَ۔۔", "content": "وضؤ کے بعد کی دعاء"},
    {"title": "۔اَللّٰھُمَّ اغْفِرْلِیْ ذَنْبِی وَوَسِّعْ لِیْ فِیْ دَارِیْ وَبَارِکْ لِیْ فِیْ رِزْقِیْ ۔", "content": "دوَران وضؤ کی دعاء"},
    {"title": "اَللّٰہُمَّ رَبَّ ھٰذِہِ الدَّعْوَةِ التَّآمَّةِ وَالصَّلٰوةِ الْقَآئِمَةِ اٰتِ مُحَمَّدَنِ الْوَسِیْلَةَ وَالْفَضِیْلَةَ وَابْعَثْہُ مَقَامًا مَّحْمُوْدَنِ الَّذِیْ وَعَدْتَّہ ۔", "content": "اذان کے بعد کی دعا"},
    {"title": "اَللّٰہُمَّ اِنِّیْ اَسْئَلُکَ رِزْقًا طَیِّبًا وَّعِلْمًا نَّافِعًاوَّعَمَلًا مُّتَقَبَّلاً ۔", "content": "نماز فجر کے بعد کی دعا"},
    {"title": "اَلْحَمْدُ لِلّٰہِ ،سُبْحٰنَ الَّذِیْ سَخَّرَلَنَاھٰذَاوَمَاکُنَّالَہ مُقْرِنِیْنَ وَاِنَّااِلٰی رَبِّنَا لَمُنْقَلِبُوْنَ۔۔", "content": "سفر کے لئے نکلنے کی دعا"},
    {"title": "اٰ ئِبُوْنَ تَآئِبُوْنَ عَابِدُوْنَ سَاجِدُوْنَ لِرَبِّنَاحَامِدُوْنَ ۔۔", "content": "سفر سے واپسی کی دعا"},
    {"title": " وَبِصَوْمِ غَدٍ نَّوَيْتُ مِنْ شَهْرِ رَمَضَانَ.۔", "content": "روزہ رکھنے کی نیت"},
    {"title": " اَللّٰهُمَّ اِنَّی لَکَ صُمْتُ وَبِکَ اٰمَنْتُ وَعَلَيْکَ تَوَکَّلْتُ وَعَلٰی رِزْقِکَ اَفْطَرْتُ۔", "content": "روزہ افطار کرنے کی دعا"},
    {"title": " اللَّهُمَّ أَحْيِنِي مَا كَانَتِ الْحَيَاةُ خَيْرٌ لِي وَتَوَفَّنِي إِذَا كَانَتِ الْوَفَاةُ خَيْرَاً لِي۔", "content": "زندگی اور موت کی دعا"},
    {"title": "اَللّٰہُمَّ ارْزُقْنِیْ شَہَادَةً فِیْ سَبِیْلِکَ وَاجْعَلْ مَوْتِیْ فِیْ بَلَدِ رَسُوْلِکَ صَلَّی اللّٰہُ عَلَیْہِ وَسَلََّمَ ۔", "content": "شہادت کی دعا"},
    {"title": " اِنَّ لِلّٰہِ مَاأَخَذَ وَلَہ مَاأَعْطٰی، وَکُلُّ شَیْیٍٔ عِنْدَہ بِأَجَلٍ مُّسَمًّی فَلْتَصْبِرْ وَلْتَحْتَسِبْ۔", "content": "تعزیت کی دعا"},
    {"title": " اَلسَّلَامُ عَلَیْکُمْ اَھْلَ الدِّیَارِ مِنَ الْمُؤْمِنِیْنَ وَالْمُسْلِمِیْنَ ،وَاِنَّااِنْ شَآئَ اللّٰہُ بِکُمْ لَلاَحِقُوْنَ أَسْأَلُ اللّٰہَ لَنَا وَلَکُمُ الْعَافِیَةَ۔", "content": "قبرستان میں داخل ہوتے وقت کی دع"},
    {"title": " بِسْمِ اللَّهِ وَعَلٰی سُنَّةِ رَسُولِ اللَّهِ۔", "content": "میت کو قبر میں رکھتے وقت کی دع"},
    {"title": " اَللّٰھُمَّ بِاسْمِکَ اَمُوْتُ وَاَحْیٰی۔", "content": "سوتے وقت کی دعا"},
    {"title": " اَلْحَمْدُلِلّٰہِ الَّذِیْ اَحْیَانَا بَعْدَ مَااَمَاتَنَا وَاِلَیْہِ النُّشُوْرُ ۔", "content": "نیند سے بیدار ہونے کی دعا"},
    {"title": " أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ۔", "content": "غصہ آنے کے وقت کی دعا"},
    {"title": " اللَّهُمَّ صَيِّبَاً نَافِعَاً۔", "content": "بارش کے وقت کی دعا"},
    {"title": " اَللّٰہُمَّ اِنِّیْ اَسْئَلُکَ خَیْرَھَا وَخَیْرَمَافِیْھَاوَخَیْرَ مَااُرْسِلَتْ بِہ وَاَعُوْذُبِکَ مِنْ شَرِّھَا وَشَرِّ مَافِیْھَاوَشَرِّ مَااُرْسِلَتْ بِہ۔", "content": "آندھی کے وقت کی دعا"},
    {"title": " اللَّهُمَّ لَا تَقْتُلْنَا بِغَضَبِكَ وَلَا تُهْلِكْنَا بِعَذَابِكَ وَعَافِنَا قَبْلَ ذَلِكَ۔", "content": "بجلی کی کڑک کے وقت کی دعا"},

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Duas'),
        backgroundColor: Colors.lightGreen,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: duasList.length,
        itemBuilder: (context, index) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 500),
            margin: EdgeInsets.symmetric(vertical: 5.0),
            decoration: BoxDecoration(
              color: Colors.lightGreen[50],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      duasList[index]['title']!,
                      style: TextStyle(
                        fontSize: 18.0,

                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      duasList[index]['content']!,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[800],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}