import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_app_1/main.dart';

import 'my_cont_page.dart';
import 'my_search.dart';

class MyFavPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MyFavPageState createState() => _MyFavPageState();
}

class _MyFavPageState extends State<MyFavPage> {
  List favPoints = [];

  @override
  void initState() {
    super.initState();
    _loadFavPoints();
  }

  Future<void> _loadFavPoints() async {
    final myAppState = Provider.of<MyAppState>(context, listen: false);
    await myAppState.updateJsonData().then((data) {
      setState(() {
        favPoints = myAppState.jsonData.values
            .whereType<Map<String, dynamic>>() // Filter only maps
            .where((item) => item['fav'] == true)
            .map((entry) => AcupuncturePoint.fromJson(entry))
            .toList();
      });
    });
    print(favPoints[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: favPoints.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyContPage(
                          myTestInput: favPoints[index].name,
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(favPoints[index].name),
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
