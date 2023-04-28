// To parse this JSON data, do
//
//     final storeModel = storeModelFromMap(jsonString);

import 'dart:convert';

List<StoreModel> storeModelFromMap(String str) => List<StoreModel>.from(json.decode(str).map((x) => StoreModel.fromMap(x)));

String storeModelToMap(List<StoreModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

List<String> categortModelFromMap(String str) => List<String>.from(json.decode(str).map((x) => x));

String categortModelToMap(List<String> data) => json.encode(List<dynamic>.from(data.map((x) => x)));

class StoreModel {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Rating rating;

  StoreModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory StoreModel.fromMap(Map<String, dynamic> json) => StoreModel(
    id: json["id"],
    title: json["title"],
    price: json["price"]?.toDouble(),
    description: json["description"],
    category: json["category"],
    image: json["image"],
    rating: Rating.fromMap(json["rating"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "category": category,
    "image": image,
    "rating": rating.toMap(),
  };
}

class Rating {
  double rate;
  int count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromMap(Map<String, dynamic> json) => Rating(
    rate: json["rate"]?.toDouble(),
    count: json["count"],
  );

  Map<String, dynamic> toMap() => {
    "rate": rate,
    "count": count,
  };
}
