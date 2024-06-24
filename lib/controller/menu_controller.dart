import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../api/model/sub_menu_model.dart';

class AppMenuController extends GetxController {
  var isSelected = false.obs;
  var categories = [].obs;
  var data = [].obs;

  // Fetch main categories with their menus
  Future<void> fetchCategories() async {
    final response = await http.get(Uri.parse("http://103.159.85.246:5000/api/main/"));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body.toString());
      categories.value = jsonData;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // Fetch sub-menu items by category
  Future<List<dynamic>> fetchMenuByCategory(String category) async {
    final response = await http.get(Uri.parse("http://103.159.85.246:5000/api/main/"));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body.toString());
      var categoryData = jsonData.firstWhere((item) => item['name'] == category, orElse: () => null);
      if (categoryData != null) {
        return categoryData['menus'];
      }
    } else {
      throw Exception('Failed to load menu items for category: $category');
    }
    return [];
  }
}
