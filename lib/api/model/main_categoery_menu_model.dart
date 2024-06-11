// To parse this JSON data, do
//
//     final model2 = model2FromJson(jsonString);

import 'dart:convert';

List<Model2> model2FromJson(String str) => List<Model2>.from(json.decode(str).map((x) => Model2.fromJson(x)));

String model2ToJson(List<Model2> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Model2 {
  String id;
  String name;
  List<Menu> menus;
  int v;

  Model2({
    required this.id,
    required this.name,
    required this.menus,
    required this.v,
  });

  factory Model2.fromJson(Map<String, dynamic> json) => Model2(
    id: json["_id"],
    name: json["name"],
    menus: List<Menu>.from(json["menus"].map((x) => Menu.fromJson(x))),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "menus": List<dynamic>.from(menus.map((x) => x.toJson())),
    "__v": v,
  };
}

class Menu {
  String id;
  String name;
  int price;
  String? imageUrl;

  Menu({
    required this.id,
    required this.name,
    required this.price,
    this.imageUrl,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    id: json["_id"],
    name: json["name"],
    price: json["price"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "price": price,
    "imageUrl": imageUrl,
  };
}
