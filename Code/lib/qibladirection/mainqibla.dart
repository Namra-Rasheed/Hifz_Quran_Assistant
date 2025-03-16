
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'qibla_compas.dart';


class MainQiblaApp extends StatefulWidget {
  @override
  _MainQiblaAppState createState() => _MainQiblaAppState();
}

class _MainQiblaAppState extends State<MainQiblaApp> {
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Qibla Direction',

      // Set app title
      home: Scaffold(
        appBar: AppBar(
        title: Text('Qibla Direction',style: TextStyle(color: Colors.white),),
          centerTitle: true,// Set the title inside AppBar
        backgroundColor: Colors.lightGreen,  // Set background color for AppBar
        leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
         Navigator.pop(context);  // Handles the back button action
         },
          ),
        ),

        body: Container(
          color: Colors.lime[50],
        child: FutureBuilder(
          future: _deviceSupport,
          builder: (_, AsyncSnapshot<bool?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error.toString()}"),
              );
            }
            if (snapshot.data!) {
              return QiblahCompass();
            } else {
              return const Center(
                child: Text("Your device does not support Qiblah detection."),
              );
            }
          },
        ),
      ),
      ),
    );
  }
}