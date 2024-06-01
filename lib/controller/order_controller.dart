import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController {
  var data = [].obs;
  var data1 = [].obs;
  var isLoading = false.obs;
  var isLoadingTables = false.obs;
  var errorMessage = ''.obs;

  Future<void> getApi() async {
    isLoading.value = true;
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
    try {
      final response = await http.get(Uri.parse("http://localhost:5000/api/table/tables?section=$section"));
      if (response.statusCode == 200) {
        data1.value = jsonDecode(response.body.toString());
      } else {
        errorMessage.value = 'Failed to load tables';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoadingTables.value = false;
    }
  }
}
