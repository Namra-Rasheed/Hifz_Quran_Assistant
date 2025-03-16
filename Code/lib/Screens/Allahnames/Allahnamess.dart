import 'package:flutter/material.dart';
class NamesOfAllah extends StatefulWidget {
  @override
  _NamesOfAllahState createState() => _NamesOfAllahState();
}

class _NamesOfAllahState extends State<NamesOfAllah> {
  final List<Map<String, String>> names = [
  {'number': '1', 'arabic': 'الرَّحْمَنُ', 'urdu': 'نہایت رحم کرنے والا', 'english': 'Ar-Rahman', 'description': 'The Most Compassionate'},
{'number': '2', 'arabic': 'الرَّحِيمُ', 'urdu': 'نہایت مہربان', 'english': 'Ar-Raheem', 'description': 'The Most Merciful'},
{'number': '3', 'arabic': 'ٱلْمَلِكُ', 'urdu': 'حقیقی بادشاہ', 'english': 'Al-Malik', 'description': 'The King and Owner of the Dominion'},
{'number': '4', 'arabic': 'الْقُدُّوسُ', 'urdu': 'پاکیزہ', 'english': 'Al-Quddus', 'description': 'The Most Sacred'},
{'number': '5', 'arabic': 'السَّلاَمُ', 'urdu': 'امن دینے والا', 'english': 'As-Salam', 'description': 'The Source of Peace'},
{'number': '6', 'arabic': 'ٱلْمُؤْمِنُ', 'urdu': 'ایمان دینے والا', 'english': 'Al-Mu’min', 'description': 'The Giver of Faith'},
{'number': '7', 'arabic': 'ٱلْمُهَيْمِنُ', 'urdu': 'نگہبان', 'english': 'Al-Muhaymin', 'description': 'The Guardian'},
{'number': '8', 'arabic': 'ٱلْعَزِيزُ', 'urdu': 'غلبہ والا', 'english': 'Al-Aziz', 'description': 'The All Mighty'},
{'number': '9', 'arabic': 'ٱلْجَبَّارُ', 'urdu': 'جبر کرنے والا', 'english': 'Al-Jabbar', 'description': 'The Compeller'},
{'number': '10', 'arabic': 'ٱلْمُتَكَبِّرُ', 'urdu': 'برتر', 'english': 'Al-Mutakabbir', 'description': 'The Supreme'},
 {'number': '11', 'arabic': 'ٱلْخَٰلِقُ', 'urdu': 'پیدا کرنے والا', 'english': 'Al-Khaaliq', 'description': 'The Creator'},
{'number': '68', 'arabic': 'ٱلْقَادِرُ', 'urdu': 'قادر', 'english': 'Al-Qadir', 'description': 'The Omnipotent'},
{'number': '69', 'arabic': 'ٱلْمُقْتَدِرُ', 'urdu': 'قادر', 'english': 'Al-Muqtadir', 'description': 'The Powerful'},
{'number': '70', 'arabic': 'ٱلْمُقَدِّمُ', 'urdu': 'آگے بڑھانے والا', 'english': 'Al-Muqaddim', 'description': 'The Expediter'},
{'number': '71', 'arabic': 'ٱلْمُؤَخِّرُ', 'urdu': 'پیچھے کرنے والا', 'english': 'Al-Mu’akhkhir', 'description': 'The Delayer'},
{'number': '72', 'arabic': 'ٱلْأوَّلُ', 'urdu': 'سب سے پہلا', 'english': 'Al-Awwal', 'description': 'The First'},
{'number': '73', 'arabic': 'ٱلْآخِرُ', 'urdu': 'سب سے آخر', 'english': 'Al-Aakhir', 'description': 'The Last'},
{'number': '74', 'arabic': 'ٱلظَّاهِرُ', 'urdu': 'ظاہر ہونے والا', 'english': 'Az-Zhaahir', 'description': 'The Manifest'},
{'number': '75', 'arabic': 'ٱلْبَاطِنُ', 'urdu': 'باطن ہونے والا', 'english': 'Al-Baatin', 'description': 'The Hidden One'},
{'number': '76', 'arabic': 'ٱلطَّوَابُ', 'urdu': 'توبہ قبول کرنے والا', 'english': 'At-Tawwab', 'description': 'The Ever-Pardoning'},
{'number': '77', 'arabic': 'ٱلْمُنْتَقِمُ', 'urdu': 'انتقام لینے والا', 'english': 'Al-Muntaqim', 'description': 'The Avenger'},
{'number': '78', 'arabic': 'ٱلْعَفُوُ', 'urdu': 'معاف کرنے والا', 'english': 'Al-‘Afuww', 'description': 'The Pardoner'},
{'number': '79', 'arabic': 'ٱلْرَّؤُوفُ', 'urdu': 'نرمی کرنے والا', 'english': 'Ar-Ra’uf', 'description': 'The Most Kind'},
{'number': '80', 'arabic': 'مَالِكُ ٱلْمُلْكُ', 'urdu': 'بادشاہی کا مالک', 'english': 'Maalik-al-Mulk', 'description': 'Owner of the Dominion'},
{'number': '81', 'arabic': 'ذُوالْجَلاَلِ وَالإكْرَامُ', 'urdu': 'عزت و جلال والا', 'english': 'Zul-Jalaali wal-Ikraam', 'description': 'Lord of Glory and Honour'},
{'number': '82', 'arabic': 'ٱلْمُقْسِطُ', 'urdu': 'انصاف کرنے والا', 'english': 'Al-Muqsiṭ', 'description': 'The Just One'},

];


bool isFront = true; // To track card side

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text(
          '99 Names of Allah (S.W.T)',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.lime[50],
        child: PageView.builder(
          itemCount: names.length,
          itemBuilder: (context, index) {
            final currentName = names[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  isFront = !isFront; // Flip the card
                });
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                transitionBuilder: (widget, animation) {
                  final rotate = Tween(begin: 1.0, end: 0.0).animate(animation);
                  return AnimatedBuilder(
                    animation: rotate,
                    builder: (context, child) {
                      final angle = (rotate.value) * 3.1416; // Convert to radians
                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(angle),
                        child: rotate.value <= 0.5 ? widget : child,
                      );
                    },
                    child: widget,
                  );
                },
                child: isFront
                    ? _buildFrontCard(currentName)
                    : _buildBackCard(currentName),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFrontCard(Map<String, String> currentName) {
    return SizedBox(

      height: 600, // Fixed height
      width: 500,  // Fixed width
      child: Card(
        color:Colors.green[100],
        key: ValueKey('front'),
        margin: const EdgeInsets.all(20),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currentName['number']!,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                currentName['arabic']!,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackCard(Map<String, String> currentName) {
    return SizedBox(
      height: 600, // Fixed height
      width: 500,  // Fixed width
      child: Card(
        key: ValueKey('back'),
        margin: const EdgeInsets.all(20),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currentName['urdu']!,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                currentName['english']!,
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  currentName['description']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
