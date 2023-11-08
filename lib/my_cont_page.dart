import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_drawer_widget.dart';
import 'main.dart';

const String myAppTitle = "Mestre Tung";

const String myTestInput = "chi-hu";

class MyContPage extends StatefulWidget {
  @override
  State<MyContPage> createState() => _MyContPageState();
}

Widget buildTextWithTags(String tag, String text) {
  return Column(
    children: [
      SizedBox(height: 16),
      Text(
        tag,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18, // Adjust the font size as needed
        ),
      ),
      Text(
        text,
        style: TextStyle(fontSize: 16), // Adjust the font size as needed
      ),
      SizedBox(height: 16), // Adjust the spacing as needed
    ],
  );
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
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              myTestInput,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24, // Adjust the font size as needed
              ),
            ),
            SizedBox(height: 20),
            buildTextWithTags("Explicação:",
                myAppState.jsonData[myTestInput]?['explication']),
            buildTextWithTags("Localização:",
                myAppState.jsonData[myTestInput]?['localization']),
            buildTextWithTags(
                "Anatomia:", myAppState.jsonData[myTestInput]?['anatomia'][0]),
            buildTextWithTags("Indicações:",
                myAppState.jsonData[myTestInput]?['indication'][0]),
            buildTextWithTags("Preparação:",
                myAppState.jsonData[myTestInput]?['preparation']),
            buildTextWithTags("Procedimento:",
                myAppState.jsonData[myTestInput]?['procedure']),
          ],
        ),
      ),
    );
  }
}
