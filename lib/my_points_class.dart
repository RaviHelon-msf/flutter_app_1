import 'dart:convert';
import 'package:flutter/services.dart';

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
      id: json['id'],
      name: json['name'],
      explication: json['explication'],
      localization: json['localization'],
      anatomy: List<String>.from(json['anatomy']),
      indication: List<String>.from(json['indication']),
      preparation: json['preparation'],
      procedure: json['procedure'],
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
