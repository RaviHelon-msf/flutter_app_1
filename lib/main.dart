import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'my_drawer_widget.dart';
// // ignore: unused_import
// import 'my_cont_page.dart';

const String myAppTitle = 'Mestre Tung';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
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

  Future<void> saveJsonData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var saveData = json.encode(jsonData);
      await prefs.setString('jsonData', saveData);
      print(saveData);
      print('JSON data saved successfully');
    } catch (e) {
      print('Error saving JSON data: $e');
    }
  }

  Future<void> updateJsonData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? savedData = prefs.getString('jsonData');
      if (savedData != null) {
        jsonData = json.decode(savedData);
        notifyListeners();
        print('JSON data updated from SharedPreferences');
      }
    } catch (e) {
      print('Error updating JSON data from SharedPreferences: $e');
    }
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isNavBarOpen = false;

  @override
  void dispose() {
    context.read<MyAppState>().saveJsonData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          )
        ],
      ),
    );
  }
}
