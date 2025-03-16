import 'package:flutter/material.dart';
import 'azkar.dart'; // Importing Azkar lists from azkar.dart file

class AzkarScreen extends StatefulWidget {
  @override
  _AzkarScreenState createState() => _AzkarScreenState();
}

class _AzkarScreenState extends State<AzkarScreen> {
  String selectedCategory = 'Morning'; // Track selected category
  final duration = Duration(milliseconds: 500); // Animation duration

  // Get the list of Azkar based on the selected category
  List<String> getAzkarList() {
    if (selectedCategory == 'Morning') {
      return getMorningAzkar(); // From azkar.dart
    } else if (selectedCategory == 'Night') {
      return getNightAzkar(); // From azkar.dart
    } else {
      return getEveningAzkar(); // From azkar.dart
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Azkar for the Day",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.lightGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Animated Category Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['Morning', 'Evening', 'Night'].map((category) {
                final isSelected = selectedCategory == category;
                return AnimatedContainer(
                  duration: duration,
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.lightGreen : Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedCategory = category; // Update category
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        fontSize: 18,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            // Azkar List Title with Fade Transition
            AnimatedSwitcher(
              duration: duration,
              child: Text(
                '$selectedCategory Azkar:',
                key: ValueKey(selectedCategory),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            // Animated ListView
            Expanded(
              child: ListView.builder(
                itemCount: getAzkarList().length,
                itemBuilder: (context, index) {
                  return TweenAnimationBuilder(
                    duration: duration,
                    tween: Tween<double>(begin: 0.8, end: 1.0),
                    curve: Curves.easeInOut,
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: child,
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.lightGreen),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        getAzkarList()[index],
                        style: TextStyle(fontSize: 16, fontFamily: 'Tajawal'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
