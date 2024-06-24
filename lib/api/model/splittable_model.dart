// section_model.dart
import 'dart:convert';

List<Model2> model2FromJson(String str) =>
    List<Model2>.from(json.decode(str).map((x) => Model2.fromJson(x)));

class Model2 {
  String id;
  String name;
  List<TableName> tableNames;

  Model2({
    required this.id,
    required this.name,
    required this.tableNames,
  });

  factory Model2.fromJson(Map<String, dynamic> json) => Model2(
    id: json["_id"],
    name: json["name"],
    tableNames: List<TableName>.from(json["tableNames"].map((x) => TableName.fromJson(x))),
  );
}

class TableName {
  final String tableName;
  final String tableId;
  final String id; // Assuming this is the _id field in your JSON

  TableName({
    required this.tableName,
    required this.tableId,
    required this.id,
  });

  factory TableName.fromJson(Map<String, dynamic> json) {
    return TableName(
      tableName: json['tableName'] ?? '',
      tableId: json['tableId'] ?? '',
      id: json['_id'] ?? '', // Assuming _id is present in your JSON
    );
  }
}

