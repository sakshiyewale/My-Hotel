import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../api/model/section_model.dart';

class OrderController extends GetxController {
  var sections = <Model1>[].obs;
  var sectionTableMap = <String, List<TableName>>{}.obs;  // Observable map to store tables grouped by section
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> getSections() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final response = await http.get(Uri.parse('http://103.159.85.246:5000/api/section/'));
      if (response.statusCode == 200) {
        sections.value = model1FromJson(response.body.toString());
        _processTableData();
      } else {
        errorMessage.value = 'Failed to load sections';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void _processTableData() {
    var map = <String, List<TableName>>{};
    for (var section in sections) {
      map[section.name] = section.tableNames
          .where((table) => RegExp(r'^\d$').hasMatch(table.tableName))  // Filter table names with single digits
          .toList();
    }
    sectionTableMap.value = map;
    print("######Sak${sectionTableMap.toString()}");
  }


}

// Assuming your section model is defined as follows:

List<Model1> model1FromJson(String str) =>
    List<Model1>.from(json.decode(str).map((x) => Model1.fromJson(x)));

String model1ToJson(List<Model1> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Model1 {
  String name;
  List<TableName> tableNames;

  Model1({
    required this.name,
    required this.tableNames,
  });

  factory Model1.fromJson(Map<String, dynamic> json) => Model1(
    name: json["name"],
    tableNames: List<TableName>.from(json["tableNames"].map((x) => TableName.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "tableNames": List<dynamic>.from(tableNames.map((x) => x.toJson())),
  };
}



// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
//
// class OrderController extends GetxController {
//   var data = [].obs;
//   var data1 = [].obs;
//   var isLoading = false.obs;
//   var isLoadingTables = false.obs;
//   var errorMessage = ''.obs;
//
//   Future<void> getApi() async {
//     isLoading.value = true;
//     try {
//       final response = await http.get(Uri.parse("http://103.159.85.246:5000/api/section/"));
//       if (response.statusCode == 200) {
//         data.value = jsonDecode(response.body.toString());
//       } else {
//         errorMessage.value = 'Failed to load sections';
//       }
//     } catch (e) {
//       errorMessage.value = 'Error: $e';
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> getTablesForSection(String section) async {
//     isLoadingTables.value = true;
//     try {
//       final response = await http.get(Uri.parse("http://103.159.85.246:5000/api/section/"));
//       if (response.statusCode == 200) {
//         data1.value = jsonDecode(response.body.toString());
//       } else {
//         errorMessage.value = 'Failed to load tables';
//       }
//     } catch (e) {
//       errorMessage.value = 'Error: $e';
//     } finally {
//       isLoadingTables.value = false;
//     }
//   }
// }
