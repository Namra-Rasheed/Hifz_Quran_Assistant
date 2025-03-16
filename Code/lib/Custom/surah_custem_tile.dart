import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/surah.dart';

class SurahCustomListTile extends StatefulWidget {
  final Surahs surah;
  final BuildContext context;
  final VoidCallback ontap;

  const SurahCustomListTile({
    required this.surah,
    required this.context,
    required this.ontap,
    Key? key,
  }) : super(key: key);

  @override
  _SurahCustomListTileState createState() => _SurahCustomListTileState();
}

class _SurahCustomListTileState extends State<SurahCustomListTile> {
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _loadBookmarkStatus();
  }

  // Load bookmark status from SharedPreferences
  void _loadBookmarkStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isBookmarked = prefs.getBool('bookmark_${widget.surah.number}') ?? false;
    setState(() {
      _isBookmarked = isBookmarked;
    });
  }

  // Save bookmark status to SharedPreferences
  void _saveBookmarkStatus(bool isBookmarked) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('bookmark_${widget.surah.number}', isBookmarked);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Surah Number with a circular background
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 40,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green, // Green color for Surah number
                  ),
                  child: Text(
                    widget.surah.number.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                // Surah's English Name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.surah.englishName!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),

                  ],
                ),
                const Spacer(),
                // Surah's Arabic Name
                Text(
                  widget.surah.name!,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                // Bookmark icon with animation
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: IconButton(
                    key: ValueKey<bool>(_isBookmarked),
                    icon: Icon(
                      _isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: _isBookmarked ? Colors.lightGreen : Colors.grey,
                      size: 28,
                    ),
                    onPressed: () {
                      setState(() {
                        _isBookmarked = !_isBookmarked; // Toggle the bookmark state
                      });
                      _saveBookmarkStatus(_isBookmarked); // Save the updated bookmark status
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
