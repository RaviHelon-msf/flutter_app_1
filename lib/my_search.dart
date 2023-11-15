import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:flutter/services.dart';

import 'my_cont_page.dart';

class MySearchPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MySearchPageState createState() => _MySearchPageState();
}

class AcupuncturePoint {
  final int id;
  final String name;
  final String explication;
  final String localization;
  final List<String> anatomy;
  final List<String> indication;
  final String preparation;
  final String procedure;

  AcupuncturePoint({
    required this.id,
    required this.name,
    required this.explication,
    required this.localization,
    required this.anatomy,
    required this.indication,
    required this.preparation,
    required this.procedure,
  });

  factory AcupuncturePoint.fromJson(Map<String, dynamic> json) {
    return AcupuncturePoint(
      id: json['id'] ?? 0, // Provide a default value for id if it's null
      name: json['name'] ?? '', // Provide a default value for name if it's null
      explication: json['explication'] ?? '',
      localization: json['localization'] ?? '',
      anatomy: (json['anatomy'] as List<dynamic>?)?.cast<String>() ?? [],
      indication: (json['indication'] as List<dynamic>?)?.cast<String>() ?? [],
      preparation: json['preparation'] ?? '',
      procedure: json['procedure'] ?? '',
    );
  }
}

Future<List<AcupuncturePoint>> loadJsonData() async {
  String data = await rootBundle.loadString('assets/data/pontos.json');

  Map<String, dynamic> jsonData = json.decode(data);

  List<AcupuncturePoint> allPoints = jsonData.entries
      .map((entry) => AcupuncturePoint.fromJson(entry.value))
      .toList();

  return allPoints;
}

class _MySearchPageState extends State<MySearchPage> {
  List<AcupuncturePoint> allAcupuncturePoints = [];
  List<AcupuncturePoint> searchResults = [];
  String selectedSearchCriteria = 'name'; // Add this line

  @override
  void initState() {
    super.initState();
    loadJsonData().then((data) {
      setState(() {
        allAcupuncturePoints = data;
        searchResults = data;
        search("", "name");
      });
    });
  }

  void search(String query, String searchBy) {
    setState(() {
      if (query.isEmpty) {
        searchResults = allAcupuncturePoints;
      } else {
        searchResults = allAcupuncturePoints.where((acupuncturePoint) {
          switch (searchBy) {
            case 'name':
              return acupuncturePoint.name
                  .toLowerCase()
                  .contains(query.toLowerCase());
            case 'anatomy':
              return acupuncturePoint.anatomy.any(
                  (item) => item.toLowerCase().contains(query.toLowerCase()));
            case 'indication':
              return acupuncturePoint.indication.any(
                  (item) => item.toLowerCase().contains(query.toLowerCase()));
            default:
              return false;
          }
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  onChanged: (query) => search(query, selectedSearchCriteria),
                  decoration: InputDecoration(
                    labelText: 'Search',
                    hintText: 'Enter search term',
                  ),
                ),
                // DropdownButton<String>(
                //   value: selectedSearchCriteria,
                //   onChanged: (value) {
                //     setState(() {
                //       selectedSearchCriteria = value!;
                //     });
                //   },
                // items: ['name', 'anatomy', 'indication']
                //     .map<DropdownMenuItem<String>>(
                //   (String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   },
                // ).toList(),
                //),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    // Navigate to AcupuncturePointDetails when the button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyContPage(
                          myTestInput: searchResults[index].name,
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(searchResults[index].name),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
