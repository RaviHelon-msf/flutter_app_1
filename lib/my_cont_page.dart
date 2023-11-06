import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_drawer_widget.dart';
import 'main.dart';

const String myAppTitle = "Mestre Tung";

class MyContPage extends StatefulWidget {
  @override
  State<MyContPage> createState() => _MyContPageState();
}

class _MyContPageState extends State<MyContPage> {
  Map<String, dynamic> jsonData = {}; // Store the JSON data here
  bool isNavBarOpen = false;

  @override
  void initState() {
    super.initState();
    // Access the instance of MyAppState created by the ChangeNotifierProvider
    Provider.of<MyAppState>(context, listen: false).loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    final myAppState = Provider.of<MyAppState>(context);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Center(
            child: Text(
              myAppTitle,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          )),
      drawer: MyDrawerWidget(),
      body: Row(
        children: [
          Text(myAppState.jsonData["chi-hu"]?['explication']),
          Text(myAppState.jsonData["chi-hu"]?['localization']),
          Text(myAppState.jsonData["chi-hu"]?['anatomia'][0]),
          Text(myAppState.jsonData["chi-hu"]?['indication'][0]),
          Text(myAppState.jsonData["chi-hu"]?['preparation']),
          Text(myAppState.jsonData["chi-hu"]?['procedure'])
        ],
      ),
    );
  }
}
