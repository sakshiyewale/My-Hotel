import 'package:flutter/material.dart';
class KOT1 extends StatefulWidget {
  const KOT1({super.key});

  @override
  State<KOT1> createState() => _KOT1State();
}

class _KOT1State extends State<KOT1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Table(
            children: [
              TableRow(
                children: [
                  TableCell(child: Text("a")),
                  TableCell(child: Text("b"))
                ]
              )
            ],
          )
        ],
      ),
    );
  }
}

//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:my_hotel/controller/connectivity_controller.dart';
// import 'package:my_hotel/controller/order_controller.dart';
// import 'package:my_hotel/screens/menu_screen.dart';
// import 'package:connectivity/connectivity.dart'; // Import the connectivity package
// import 'package:sizer/sizer.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
//
// import '../utils/app_colors.dart';
//
// class OrderScreen extends StatefulWidget {
//   const OrderScreen({Key? key}) : super(key: key);
//
//   @override
//   State<OrderScreen> createState() => _OrderScreenState();
// }
//
// class _OrderScreenState extends State<OrderScreen> {
//   OrderController orderController = Get.put(OrderController());
//   int selectedIndex = 0;
//   String? selectedSection;
//   int selectedTableIndex = 0;
//   Map<String, int> selectedItems = {};
//
//   @override
//   void initState() {
//     super.initState();
//     orderController.getApi();
//     _loadSelectedItems();
//     _loadSelectedSection();
//     _loadSelectedTable();
//     checkInternetConnectivity(); // Call the method to check internet connectivity
//   }
//
//   // Method to check internet connectivity
//   Future<void> checkInternetConnectivity() async {
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     if (connectivityResult == ConnectivityResult.none) {
//       // No internet connection
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("No Internet Connection"),
//             content: Text("Please check your internet connection."),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
//
// // Remaining code...
