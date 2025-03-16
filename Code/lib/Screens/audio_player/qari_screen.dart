import 'package:flutter/material.dart';

import '../../models/qari.dart';
import '../../services/apiServices.dart';
import 'audio surah screen.dart';
import 'qaricustom_tile.dart';

class QariListScreen extends StatefulWidget {
  const QariListScreen({Key? key}) : super(key: key);

  @override
  _QariListScreenState createState() => _QariListScreenState();
}

class _QariListScreenState extends State<QariListScreen> {
  ApiServices apiServices = ApiServices();
  late TextEditingController _searchController;
  late List<Qari> _filteredQaris;
  late List<Qari> _qariList;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredQaris = [];
    _qariList = [];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Filter the Qari list based on exact match search input or partial matches
  void _filterQaris(String query) {
    query = query.trim().toLowerCase();

    if (query.isNotEmpty) {
      // Filter the Qari list based on the search query
      List<Qari> filteredQaris = _qariList.where((qari) {
        // Check for exact match or partial match
        return qari.name!.toLowerCase().contains(query);
      }).toList();

      // Sort the filtered Qaris to bring the exact match at the top
      filteredQaris.sort((a, b) {
        if (a.name!.toLowerCase() == query) return -1;  // Exact match goes to the top
        if (b.name!.toLowerCase() == query) return 1;
        return 0;
      });

      setState(() {
        _filteredQaris = filteredQaris;
      });
    } else {
      setState(() {
        _filteredQaris = _qariList; // Show all if no search query
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) => _filterQaris(value),
                  decoration: InputDecoration(
                    labelText: 'Search by Qari Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: _searchController.text.isNotEmpty ? Colors.green : Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: _searchController.text.isNotEmpty ? Colors.green : Colors.grey),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Expanded(
                child: FutureBuilder(
                  future: apiServices.getQariList(),
                  builder: (BuildContext context, AsyncSnapshot<List<Qari>> snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Qari\'s data not found'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.data != null) {
                      _qariList = snapshot.data!;
                      _filteredQaris = _qariList; // Initially show all Qaris
                    }

                    if (_filteredQaris.isEmpty) {
                      return Center(child: Text('No data found'));
                    }

                    return ListView.builder(
                      itemCount: _filteredQaris.length,
                      itemBuilder: (context, index) {
                        return QariCustomTile(
                          qari: _filteredQaris[index],
                          ontap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AudioSurahScreen(qari: _filteredQaris[index]),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
