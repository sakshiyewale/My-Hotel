// import 'dart:convert';
//
// import 'package:get/get.dart';
//
// import '../api/model/section_model.dart';
// import 'package:http/http.dart'as http;
//
//
// class OrderController extends GetxController
// {
//   // List<Model1>abc=[];
//   // Future<List<Model1>> getApi() async {
//   //   final response=await http.get(Uri.parse("http://localhost:5000/api/section/"));
//   //   var data=jsonDecode(response.body.toString());
//   //   if(response.statusCode==200)
//   //   {
//   //     for(var index in data)
//   //     {
//   //       abc.add(Model1.fromJson(index));
//   //     }
//   //     return abc;
//   //   }
//   //   else{
//   //     return abc;
//   //   }
//
//   var data;
//
//   Future<void> getApi()async{
//     final response=await http.get(Uri.parse("http://localhost:5000/api/section/"));
//     print('111');
//     if(response.statusCode==200)
//     {
//       data=jsonDecode(response.body.toString());
//       print('222');
//       print("#############$data");
//       return;
//     }
//     else{
//
//     }
//   }
//
// var data1;
//   Future<void>MainHall()async{
//     final response =await http.get(Uri.parse("http://localhost:5000/api/table/tables"));
//     if(response.statusCode==200)
//       {
//         data1=jsonDecode(response.body.toString());
//         print('######$data');
//       }
//     else{
//
//     }
//   }
//
// }


import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController {
  var data = [].obs;
  var data1 = [].obs;
  var isLoading = false.obs;
  var isLoadingTables = false.obs;
  var errorMessage = ''.obs;
  var sectionTableMap = {}.obs;  // New observable map to store tables grouped by section

  Future<void> getApi() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final response = await http.get(Uri.parse("http://localhost:5000/api/section/"));
      if (response.statusCode == 200) {
        data.value = jsonDecode(response.body.toString());
      } else {
        errorMessage.value = 'Failed to load sections';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getTablesForSection(String section) async {
    isLoadingTables.value = true;
    errorMessage.value = '';
    try {
      final response = await http.get(Uri.parse("http://localhost:5000/api/table/tables?section=$section"));
      if (response.statusCode == 200) {
        data1.value = jsonDecode(response.body.toString());
        _processTableData();
      } else {
        errorMessage.value = 'Failed to load tables';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoadingTables.value = false;
    }
  }


  void _processTableData() {
    var map = {};
    for (var item in data1) {
      var sectionName = item['section']['name'];
      if (map[sectionName] == null) {
        map[sectionName] = [];
      }
      map[sectionName].add(item['tableName']);
    }
    sectionTableMap.value = map;
  }
}
