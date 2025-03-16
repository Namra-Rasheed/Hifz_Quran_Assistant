import 'package:flutter/material.dart';

class Fasting extends StatefulWidget {
  const Fasting({Key? key}) : super(key: key);

  @override
  State<Fasting> createState() => _FastingState();
}

class _FastingState extends State<Fasting> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // Set length to 3 for 3 tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fasting',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.black, // Color of the indicator line
          labelColor: Colors.white, // Color of the selected tab's text
          unselectedLabelColor: Colors.black, // Color of the unselected tabs' text
          labelStyle: TextStyle(
            fontSize: 18, // Font size of the selected tab
            fontWeight: FontWeight.bold, // Font weight of the selected tab
          ),
          tabs: const [
            Tab(text: 'Fasting(روزہ)'),
            Tab(text: 'Fasting(روزہ)'),
            Tab(text: 'Fasting(روزہ)'),
          ],
        ),
      ),
      body: Container(
    color: Colors.lime[50],
     child:  TabBarView(
        controller: _tabController,
        children: [
          // First Tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [

                  Text(
                    'روزہ رکھنے کی نیت',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),

                const SizedBox(height: 16), // Add some space between cards
                Card(
                  color: Colors.green[50],
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'وَبِصَوْمِ غَدٍ نَّوَيْتُ مِنْ شَهْرِ رَمَضَانَ۔',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'اورمیں نے ماہ رمضان کے کل کے روزے کی نیت کی',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          '"I Intend to keep the fast for month of Ramadan."',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),


          // Second Tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [

                        Text(
                          'روزہ افطار کرنے کی دعا',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),

                Card(
                  margin: EdgeInsets.only(top: 15.0),
                  color: Colors.green[50],
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'اَللّٰھُمَّ لَکَ صُمْتُ وَعَلٰی رِزْقِکَ اَفْطَرْتُ ۔',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'اے اللہ !میں نے تیری رضا کے لئے روزہ رکھا اور تیرے ہی رزق پر افطار کی',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          '"O Allah! I fasted for you and i believe in you [and i put my trust in you] and i break my fast with your sustenance."',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.only(top: 15.0),
                  color: Colors.green[50],
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          ' اللّٰهُمَّ إِنِّي أَسْأَلُكَ بِرَحْمَتِكَ الَّتِي وَسِعَتْ كُلَّ شَيْءٍ أَنْ تَغْفِرَ لِيُ۔',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'اللّٰہ! بیشک میں تجھ سے تیری رحمت کے ذریعے سے سوال کرتا ہوں، جس [رحمت] نے ہر چیز کو گھیر رکھا ہے کہ تو مجھے بخش دے',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          '"O Allah, I ask You by Your mercy, which has encompassed everything, to forgive me."',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Third Tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [

                        Text(
                          'روزہ افطار کروانے والے کے لیے دعا',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),

                Card(
                  margin: EdgeInsets.only(top: 17.0),
                  color: Colors.green[50],
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'اَفْطَرَعِنْدَ کُمُ الصَّآئِمُوْنَ وَاَکَلَ طَعَامَکُمُ الْابَرَارُ وَصَلَّتْ عَلَیْکُمُ الْمَلَآئِکَةُ۔',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        const Text(
                         'افطارکیا کریں تمہارے یہاں روزہ دار لوگ اور کھایا کریں تمہارا کھانا نیک لوگ اور رحمت کی دعا کیا کریں تمہارے لئے فرشتے',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          '"May the fasting (people) break their fast in your home, and may the dutiful and pious eat your food, and may the angels send prayers upon you."',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}
