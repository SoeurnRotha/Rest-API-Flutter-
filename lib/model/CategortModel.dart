
import 'dart:convert';

List<String> categortModelFromMap(String str) => List<String>.from(json.decode(str).map((x) => x));
String categortModelToMap(List<String> data) => json.encode(List<dynamic>.from(data.map((x) => x)));
