import 'package:flutter/material.dart';
import '../../models/qari.dart';

class QariCustomTile extends StatefulWidget {
  const QariCustomTile({Key? key, required this.qari, required this.ontap})
      : super(key: key);

  final Qari qari;
  final VoidCallback ontap;

  @override
  _QariCustomTileState createState() => _QariCustomTileState();
}

class _QariCustomTileState extends State<QariCustomTile> {
  double _scale = 1.0;
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _scale = 1.1;  // scale up
          _opacity = 0.8;  // fade out a bit
        });

        // Call the onTap callback passed to the widget
        widget.ontap();

        // Reset the scale and opacity after animation
        Future.delayed(Duration(milliseconds: 200), () {
          setState(() {
            _scale = 1.0; // return to normal size
            _opacity = 1.0; // return to full opacity
          });
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.lightGreen[50],
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                spreadRadius: 0,
                color: Colors.black12,
                offset: Offset(0, 1),
              ),
            ],
          ),
          transform: Matrix4.identity()..scale(_scale),
          child: AnimatedOpacity(
            opacity: _opacity,
            duration: Duration(milliseconds: 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.qari.name!,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
