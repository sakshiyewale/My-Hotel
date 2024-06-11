// To parse this JSON data, do
//
//     final model3 = model3FromJson(jsonString);

import 'dart:convert';

List<Model3> model3FromJson(String str) => List<Model3>.from(json.decode(str).map((x) => Model3.fromJson(x)));

String model3ToJson(List<Model3> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Model3 {
  String id;
  String name;
  List<Menu> menus;
  int v;

  Model3({
    required this.id,
    required this.name,
    required this.menus,
    required this.v,
  });

  factory Model3.fromJson(Map<String, dynamic> json) => Model3(
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
  Id? id;
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
    id: json["_id"] == null ? null : Id.fromJson(json["_id"]),
    name: json["name"],
    price: json["price"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id?.toJson(),
    "name": name,
    "price": price,
    "imageUrl": imageUrl,
  };
}

class Id {
  String id;
  String name;
  int price;
  int v;
  String? imageUrl;
  String? uniqueId;
  int stockQty;
  MainCategory? mainCategory;

  Id({
    required this.id,
    required this.name,
    required this.price,
    required this.v,
    this.imageUrl,
    this.uniqueId,
    required this.stockQty,
    this.mainCategory,
  });

  factory Id.fromJson(Map<String, dynamic> json) => Id(
    id: json["_id"],
    name: json["name"],
    price: json["price"],
    v: json["__v"],
    imageUrl: json["imageUrl"],
    uniqueId: json["uniqueId"],
    stockQty: json["stockQty"],
    mainCategory: json["mainCategory"] == null ? null : MainCategory.fromJson(json["mainCategory"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "price": price,
    "__v": v,
    "imageUrl": imageUrl,
    "uniqueId": uniqueId,
    "stockQty": stockQty,
    "mainCategory": mainCategory?.toJson(),
  };
}

class MainCategory {
  IdEnum id;
  Name name;

  MainCategory({
    required this.id,
    required this.name,
  });

  factory MainCategory.fromJson(Map<String, dynamic> json) => MainCategory(
    id: idEnumValues.map[json["id"]]!,
    name: nameValues.map[json["name"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": idEnumValues.reverse[id],
    "name": nameValues.reverse[name],
  };
}

enum IdEnum {
  THE_662_C9_C75584_E785345_B7_BDF4,
  THE_664_F129_D3_FFDE346628369_AF,
  THE_6654201854_A8_CAD3_B45_B79_A8
}

final idEnumValues = EnumValues({
  "662c9c75584e785345b7bdf4": IdEnum.THE_662_C9_C75584_E785345_B7_BDF4,
  "664f129d3ffde346628369af": IdEnum.THE_664_F129_D3_FFDE346628369_AF,
  "6654201854a8cad3b45b79a8": IdEnum.THE_6654201854_A8_CAD3_B45_B79_A8
});

enum Name {
  DINNER,
  NON_VEG,
  TEA
}

final nameValues = EnumValues({
  "Dinner": Name.DINNER,
  "Non-veg": Name.NON_VEG,
  "Tea": Name.TEA
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
