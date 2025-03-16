import 'package:flutter/material.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Custom/custom_translation.dart';
import '../contant/contant.dart';
import '../models/translation.dart';
import '../services/apiServices.dart';

enum Translation { urdu,  english }

class Surahdetail extends StatefulWidget {
  const Surahdetail({Key? key}) : super(key: key);

  static const String id = 'surahDetail_screen';

  @override
  _SurahdetailState createState() => _SurahdetailState();
}

class _SurahdetailState extends State<Surahdetail> with SingleTickerProviderStateMixin {
  final ApiServices _apiServices = ApiServices();
  Translation? _translation = Translation.urdu;
  final SolidController _controller = SolidController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // To track bookmarked Ayahs
  final Set<int> _bookmarkedAyahs = {};

  @override
  void initState() {
    super.initState();
    _loadBookmarkedAyahs();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    // Start the animation on load
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Load bookmarked Ayahs from SharedPreferences
  void _loadBookmarkedAyahs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<int> bookmarkedAyahs = prefs.getStringList('bookmarkedAyahs')?.map((e) => int.parse(e)).toSet() ?? {};
    setState(() {
      _bookmarkedAyahs.addAll(bookmarkedAyahs);
    });
  }

  // Save bookmarked Ayahs to SharedPreferences
  void _saveBookmarkedAyahs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookmarkedAyahs = _bookmarkedAyahs.map((e) => e.toString()).toList();
    prefs.setStringList('bookmarkedAyahs', bookmarkedAyahs);
  }

  void _toggleBookmark(int index) {
    setState(() {
      if (_bookmarkedAyahs.contains(index)) {
        _bookmarkedAyahs.remove(index);
      } else {
        _bookmarkedAyahs.add(index);
      }
      _saveBookmarkedAyahs(); // Save updated bookmarks
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Surah ",style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.lightGreen,
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: _apiServices.getTranslation(Constants.surahIndex!, _translation!.index),
          builder: (BuildContext context, AsyncSnapshot<SurahTranslationList> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.translationList.length,
                    itemBuilder: (context, index) {
                      final ayah = snapshot.data!.translationList[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        color: Colors.green[50],
                        elevation: 4,
                        child: ListTile(

                          contentPadding: const EdgeInsets.all(16),
                          title: Text(
                            ayah.arabic_text ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.right, // Arabic text alignment
                          ),
                          subtitle: Text(
                            ayah.translation ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black, // Changed from grey to black
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () => _toggleBookmark(index),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) =>
                                  ScaleTransition(scale: animation, child: child),
                              child: Icon(
                                _bookmarkedAyahs.contains(index)
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                key: ValueKey<bool>(_bookmarkedAyahs.contains(index)),
                                color: _bookmarkedAyahs.contains(index) ? Colors.lightGreen : Colors.grey,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            } else {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: const Center(
                  child: Text(
                    'Translation Not Found',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                ),
              );
            }
          },
        ),
        bottomSheet: SolidBottomSheet(
          controller: _controller,
          headerBar: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              color: Colors.lightGreen,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            height: 50,
            child: Center(
              child: Text(
                _controller.isOpened ? "Swipe " : "Swipe for options",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          toggleVisibilityOnTap: true,
          body: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  _buildRadioTile(context, "Urdu", Translation.urdu),
                  _buildRadioTile(context, "English", Translation.english),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRadioTile(BuildContext context, String title, Translation value) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      leading: Radio<Translation>(
        value: value,
        groupValue: _translation,
        activeColor: Theme.of(context).primaryColor,
        onChanged: (Translation? selected) {
          setState(() {
            _translation = selected;
          });
        },
      ),
    );
  }
}
