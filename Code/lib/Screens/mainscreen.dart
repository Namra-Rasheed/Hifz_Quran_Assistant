import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'Audioscreen.dart';
import 'Homescreen.dart';
import 'Othersoptions.dart';
import 'Quranscreen.dart';

class mainscreen extends StatefulWidget {
  const mainscreen({super.key});

  @override
  State<mainscreen> createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {
  int selectindex = 0;
  List<Widget> _widgetList = [homescreen(),QuranScreen(),AudioScreen(),Others()];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _widgetList[selectindex],
          ),
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        height: 55,
        backgroundColor: Colors.lightGreen,
        items: [
          TabItem(
              icon: Image.asset('images/homeremove.png', height: 12,
                width: 24,), title: 'Home'),
          TabItem(icon: Image.asset('images/quranicon.png'), title: 'Quran'),
          TabItem(icon: Image.asset('images/audioremove.png'), title: 'Audio'),
          TabItem(icon: Image.asset('images/other.png'), title: 'Others'),
        ],
        initialActiveIndex: 0,
        onTap: updateIndex,
      ),
    )
    );
  }
  void updateIndex(index){
    setState(() {
      selectindex = index;
    });
  }

}
