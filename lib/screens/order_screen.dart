import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_hotel/controller/order_controller.dart';
import 'package:sizer/sizer.dart';
import '../utils/app_colors.dart';
import 'data_screen.dart';
// Import the new screen

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  OrderController orderController = Get.find();
  int selectedIndex = 0;
  int? selectedTableIndex;

  @override
  void initState() {
    super.initState();
    orderController.getApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 10.h,
            width: 100.w,
            child: Obx(() {
              if (orderController.data.isEmpty) {
                return Center(child: CircularProgressIndicator());
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
          SizedBox(height: 20),
          // Display MainHall, ACHall, or Selected Category
          selectedIndex == 0 ? _MainHall() : _ACHall(),
        ],
      ),
    );
  }

  Widget _MainHall() {
    return Expanded(
      child: Obx(() {
        if (orderController.data1.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          return GridView.builder(
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.sp,
              mainAxisSpacing: 10.sp,
            ),
            itemCount: orderController.data1.length,
            itemBuilder: (context, index) {
              return _buildTableWidget(orderController.data1[index]["tableName"].toString(), index);
            },
          );
        }
      }),
    );
  }

  Widget _ACHall() {
    return Expanded(
      child: Obx(() {
        if (orderController.data1.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          return GridView.builder(
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.sp,
              mainAxisSpacing: 10.sp,
            ),
            itemCount: orderController.data1.length,
            itemBuilder: (context, index) {
              return _buildTableWidget(orderController.data1[index]["tableName"].toString(), index);
            },
          );
        }
      }),
    );
  }

  Widget _buildTableWidget(String tableName, int index) {
    bool isSelected = selectedTableIndex == index;
    Color containerColor = isSelected ? Colors.orangeAccent : Colors.white;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTableIndex = index;
        });
        // Navigate to the TableDetailsScreen when a table is selected
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TableDetailsScreen(tableName: tableName),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: containerColor,
          border: Border.all(color: Colors.grey),
        ),
        child: Center(
          child: Text(tableName),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String category, int index) {
    bool isSelected = selectedIndex == index;
    Color containerColor = isSelected ? Colors.orangeAccent : ColorsForApp.whiteColor;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          selectedTableIndex = null; // Reset table selection when category changes
        });
        // Fetch tables for the selected category
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
            fontSize: 9.sp,
            fontWeight: FontWeight.w500,
            color: isSelected ? ColorsForApp.whiteColor : ColorsForApp.blackColor,
          ),
        ),
      ),
    );
  }
}
