import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/juzmodel.dart';

class JuzCustomTile extends StatefulWidget {
  final List<JuzAyahs> list;
  final int index;

  JuzCustomTile({required this.list, required this.index});

  @override
  _JuzCustomTileState createState() => _JuzCustomTileState();
}

class _JuzCustomTileState extends State<JuzCustomTile> {
  bool _isBookmarked = false; // Track the bookmark state

  @override
  void initState() {
    super.initState();
    _loadBookmarkState();
  }

  // Load the bookmark state from SharedPreferences
  void _loadBookmarkState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isBookmarked = prefs.getBool('bookmark_${widget.index}');
    setState(() {
      _isBookmarked = isBookmarked ?? false; // Default to false if no value is found
    });
  }

  // Save the bookmark state to SharedPreferences
  void _saveBookmarkState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('bookmark_${widget.index}', _isBookmarked);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.all(14.0),
      duration: Duration(milliseconds: 300), // Smooth transition when expanded
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(16), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Ayah Number
          Text(
            widget.list[widget.index].ayahNumber.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),

          // Ayah Text with a beautiful style
          Text(
            widget.list[widget.index].ayahsText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.end,
          ),
          SizedBox(height: 8),

          // Surah Name
          Text(
            widget.list[widget.index].surahName,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10),

          // Bookmark Icon with animation
          GestureDetector(
            onTap: () {
              setState(() {
                _isBookmarked = !_isBookmarked;
                _saveBookmarkState(); // Save state when the bookmark is toggled
              });
            },
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(
                _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                key: ValueKey<bool>(_isBookmarked),
                color: _isBookmarked ? Colors.black : Colors.grey,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
