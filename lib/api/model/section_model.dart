import 'dart:convert';

List<Model1> model1FromJson(String str) =>
    List<Model1>.from(json.decode(str).map((x) => Model1.fromJson(x)));

String model1ToJson(List<Model1> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Model1 {
  String id;
  String name;
  bool isDefault;
  int acPercentage;
  List<TableName> tableNames;
  int v;

  Model1({
    required this.id,
    required this.name,
    required this.isDefault,
    required this.acPercentage,
    required this.tableNames,
    required this.v,
  });

  factory Model1.fromJson(Map<String, dynamic> json) => Model1(
    id: json["_id"],
    name: json["name"],
    isDefault: json["isDefault"],
    acPercentage: json["acPercentage"],
    tableNames: List<TableName>.from(
        json["tableNames"].map((x) => TableName.fromJson(x))),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "isDefault": isDefault,
    "acPercentage": acPercentage,
    "tableNames": List<dynamic>.from(tableNames.map((x) => x.toJson())),
    "__v": v,
  };
}

class TableName {
  String tableName;
  String tableId;
  String id;

  TableName({
    required this.tableName,
    required this.tableId,
    required this.id,
  });

  factory TableName.fromJson(Map<String, dynamic> json) => TableName(
    tableName: json["tableName"],
    tableId: json["tableId"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "tableName": tableName,
    "tableId": tableId,
    "_id": id,
  };
}
