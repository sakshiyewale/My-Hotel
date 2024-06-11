import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_hotel/controller/connectivity_controller.dart';
import 'package:my_hotel/controller/order_controller.dart';
import 'package:my_hotel/screens/menu_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../utils/app_colors.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  ConnectivityController connectivityController =
  Get.put(ConnectivityController(), permanent: true);
  OrderController orderController = Get.put(OrderController());
  int selectedIndex = 0;
  String? selectedSection;
  int selectedTableIndex = 0;
  Map<String, int> selectedItems = {};

  @override
  void initState() {
    super.initState();
    orderController.getApi();
    _loadSelectedItems();
    _loadSelectedSection();
    _loadSelectedTable();
  }
  // Future<void> _loadSelectedItems() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? selectedItemsJson = prefs.getString('selectedItems');
  //   if (selectedItemsJson != null) {
  //     setState(() {
  //       selectedItems = Map<String, int>.from(jsonDecode(selectedItemsJson));
  //     });
  //   }
  // }

  Future<void> _loadSelectedSection() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedSelectedSection = prefs.getString('selectedSection');
    if (storedSelectedSection != null) {
      setState(() {
        selectedSection = storedSelectedSection;
        selectedIndex = orderController.data.indexWhere((element) => element['name'] == storedSelectedSection);
      });
      if (selectedSection != null) {
        orderController.getTablesForSection(selectedSection!);
      }
    }
  }

  Future<void> _loadSelectedTable() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedTableName = prefs.getString('selectedTableName');
    if (selectedTableName != null && selectedSection != null) {
      setState(() {
        selectedTableIndex = orderController.sectionTableMap[selectedSection]?.indexOf(selectedTableName) ?? 0;
      });
    }
  }

  Future<void> _saveSelectedSection(String category) async {
    if (category != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('selectedSection', category);
    }
  }

  Future<void> _saveSelectedTable(String tableName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedTableName', tableName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Container(
              height: 7.h,
              width: 100.w,
              child: Obx(() {
                if (orderController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (orderController.errorMessage.isNotEmpty) {
                  return Center(child: Text(orderController.errorMessage.value));
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: orderController.data.length,
                    itemBuilder: (context, index) {
                      return _buildCategoryButton(
                        orderController.data[index]['name'].toString(),
                        index,
                      );
                    },
                  );
                }
              }),
            ),
          ),
          SizedBox(height: 20),
          Obx(() {
            if (orderController.isLoadingTables.value) {
              return Expanded(child: Center(child: CircularProgressIndicator()));
            } else if (orderController.errorMessage.isNotEmpty) {
              return Expanded(child: Center(child: Text(orderController.errorMessage.value)));
            } else {
              return _buildTablesList();
            }
          }),
        ],
      ),
    );
  }

  Widget _buildTablesList() {
    if (selectedSection == null || orderController.sectionTableMap[selectedSection] == null) {
      return Expanded(child: Center(child: Text('No tables available')));
    } else {
      var tables = orderController.sectionTableMap[selectedSection];
      return Expanded(
        child: GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.sp,
            mainAxisSpacing: 10.sp,
          ),
          itemCount: tables.length,
          itemBuilder: (context, index) {
            return _buildTableWidget(tables[index].toString(), index);
          },
        ),
      );
    }
  }

  Widget _buildTableWidget(String tableName, int index) {
    bool isSelected = selectedTableIndex == index;
    Color containerColor = isSelected ? Colors.orangeAccent : Colors.white;

    return FutureBuilder(
      future: _loadSelectedItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error loading data');
        } else {
          Map<String, int> selectedItems = snapshot.data as Map<String, int>;
          int itemCount = selectedItems[tableName] ?? 0;

          return GestureDetector(
            onTap: () async {
              setState(() {
                selectedTableIndex = index;
              });
              await _saveSelectedTable(tableName);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AppMenuScreen(),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: containerColor,
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.dining_sharp,
                    size: 28.sp,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                  SizedBox(height: 10),
                  Text(
                    tableName,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  if (itemCount > 0) ...[
                    SizedBox(height: 5),
                    Text(
                      'Items: $itemCount',
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    ),
                  ],
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Future<Map<String, int>> _loadSelectedItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedItemsJson = prefs.getString('selectedItems');
    if (selectedItemsJson != null) {
      return Map<String, int>.from(jsonDecode(selectedItemsJson));
    } else {
      return {};
    }
  }

  Widget _buildCategoryButton(String category, int index) {
    bool isSelected = selectedIndex == index;
    Color containerColor = isSelected ? Colors.orangeAccent : Colors.white;

    return GestureDetector(
      onTap: () async {
        setState(() {
          selectedIndex = index;
          selectedSection = category;
        });
        await _saveSelectedSection(category);
        orderController.getTablesForSection(category);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? Colors.orangeAccent : ColorsForApp.blackColor),
          borderRadius: BorderRadius.circular(5),
          color: containerColor,
        ),
        child: Text(
          category,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            color: isSelected ? ColorsForApp.whiteColor : ColorsForApp.blackColor,
          ),
        ),
      ),
    );
  }
}
