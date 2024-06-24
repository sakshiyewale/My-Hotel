// // split_table_controller.dart
//
// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:my_hotel/api/model/section_model.dart';
//
// import '../api/model/main_categoery_menu_model.dart';
//
// class SplitTableController extends GetxController {
//   var sections = <Model2>[].obs;
//   var sectionTableMap = <String, List<TableName>>{}.obs;
//   var isLoading = false.obs;
//   var errorMessage = ''.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     getSections();
//   }
//
//   Future<void> getSections() async {
//     isLoading.value = true;
//     errorMessage.value = '';
//     try {
//       final response = await http.get(
//         Uri.parse('http://103.159.85.246:5000/api/section/'),
//       );
//       if (response.statusCode == 200) {
//         sections.value = model2FromJson(response.body);
//         _processTableData();
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
//   void _processTableData() {
//     sectionTableMap.clear(); // Clear existing data if any
//
//     for (var section in sections) {
//       // Filter table names with format '1A', '1B', '1C', etc.
//       var filteredTables = section.tableNames
//           .where((table) => RegExp(r'^\d+[A-Z]$').hasMatch(table.tableName))
//           .toList();
//
//       sectionTableMap[section.name] = filteredTables;
//     }
//
//     print('Processed Section-Table Map: $sectionTableMap');
//   }
//
//   List<TableName>? getTableDataForSection(String sectionName) {
//     return sectionTableMap[sectionName];
//   }
//
//   List<String>? getSubTablesForTable(String sectionName, String tableName) {
//     var selectedSection = sections.firstWhere(
//           (section) => section.name == sectionName,
//       orElse: () => Model2(
//         id: '', // Replace with appropriate default value
//         name: '', // Replace with appropriate default value
//         tableNames: [], // Replace with appropriate default value
//         v: 0, menus: [], // Replace with appropriate default value
//       ),
//     );
//
//     var selectedTable = selectedSection.tableNames
//         .where((table) => table.tableName == tableName)
//         .toList();
//
//     if (selectedTable.isNotEmpty) {
//       return selectedTable.map((table) => table.tableId).toList();
//     } else {
//       return null;
//     }
//   }
// }



import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../api/model/main_categoery_menu_model.dart';
import '../api/model/section_model.dart'; // Adjust path as per your project structure

class SplitTableController extends GetxController {
  var sections = <Model2>[].obs;
  var sectionTableMap = <String, List<TableName>>{}.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getSections();
  }

  Future<void> getSections() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await http.get(
        Uri.parse('http://103.159.85.246:5000/api/section/'),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        sections.assignAll(jsonResponse.map((e) => Model2.fromJson(e)).toList());
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
    sectionTableMap.clear(); // Clear existing data if any

    for (var section in sections) {
      var filteredTables = section.tableNames
          .where((table) => RegExp(r'^\d+[A-Z]$').hasMatch(table.tableName))
          .toList();

      sectionTableMap[section.name] = filteredTables;
    }

    print('Processed Section-Table Map: $sectionTableMap');
  }

  List<TableName>? getTableDataForSection(String sectionName) {
    return sectionTableMap[sectionName];
  }

  List<String>? getSubTablesForTable(String sectionName, String tableName) {
    var selectedSection = sections.firstWhere(
          (section) => section.name == sectionName,
      orElse: () => Model2(
        id: '',
        name: '',
        tableNames: [],
        v: 0, menus: [],
      ),
    );

    var selectedTable = selectedSection.tableNames
        .where((table) => table.tableName == tableName)
        .toList();

    if (selectedTable.isNotEmpty) {
      return selectedTable.map((table) => table.tableId).toList();
    } else {
      return null;
    }
  }
}





