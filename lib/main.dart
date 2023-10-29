import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'my_drawer_widget.dart';

const String myAppTitle = "Mestre Tung";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final myColorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xffF5F5DC), // Your primary color
      secondary: Color(0xFFCFB997), // Your secondary color
      surface: Color(0xFFE1C699), // Background surface color
      background: Color(0xFFE1C699), // App background color
      error: Colors.red, // Error color
      onPrimary: Colors.black, // Text and icons on primary color
      onSecondary: Color(0xff964B00), // Text and icons on secondary color
      onSurface: Color(0xFF964B00), // Text and icons on surface color
      onBackground: Colors.black, // Text and icons on background color
      onError: Colors.white, // Text and icons on error color
    );

    final myTheme = ThemeData(
      useMaterial3: true,
      colorScheme: myColorScheme, // Apply your custom color scheme
      primaryColor: myColorScheme.primary, // Primary color for the app
      // Define other theme properties like text styles, fonts, etc.
    );

    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: myAppTitle,
        theme: myTheme,
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  Map<String, dynamic> jsonData = {}; // Store the JSON data here

  Future<void> loadJsonData() async {
    try {
      String jsonDataString =
          await rootBundle.loadString('assets/data/pontos.json');
      jsonData = json.decode(jsonDataString);
      // Notify listeners if you need to update the UI when data is loaded.
      notifyListeners();
    } catch (e) {
      print('Error loading JSON data: $e');
    }
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Center(
                child: Image.asset('assets/body.png'),
              ),
            ),
          ),
          Text(myAppState.jsonData["chi-hu"]["explication"])
        ],
      ),
    );
  }
}
