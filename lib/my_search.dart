import 'package:flutter/material.dart';
import 'my_points_class.dart';

class MySearchPage extends StatefulWidget {
  @override
  _MySearchPageState createState() => _MySearchPageState();
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
      });
    });
  }

  void search(String query, String searchBy) {
    setState(() {
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
                DropdownButton<String>(
                  value: selectedSearchCriteria,
                  onChanged: (value) {
                    setState(() {
                      selectedSearchCriteria = value!;
                    });
                  },
                  items: ['name', 'anatomy', 'indication']
                      .map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(searchResults[index].name),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
