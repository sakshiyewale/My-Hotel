import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_hotel/controller/split_controller.dart';
import 'package:sizer/sizer.dart';

class SplitTableScreen extends StatelessWidget {
  final String tableName;
  final String selectedSection;

  const SplitTableScreen({
    Key? key,
    required this.tableName,
    required this.selectedSection, required String selectedTableName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SplitTableController splitTableController = Get.put(
        SplitTableController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Table'),
      ),
      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Padding(
      //       padding: EdgeInsets.all(10.sp),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Text('Selected Section: $selectedSection'),
      //           Text('Split Table: $tableName'),
      //           FloatingActionButton(
      //             backgroundColor: Colors.grey.shade100,
      //             onPressed: () {
      //               // Handle button press if needed
      //             },
      //             child: Icon(Icons.add),
      //           ),
      //         ],
      //       ),
      //     ),
      //     Expanded(
      //       child: SingleChildScrollView(
      //         child: Obx(() {
      //           if (splitTableController.isLoading.value) {
      //             return Center(child: CircularProgressIndicator());
      //           } else
      //           if (splitTableController.sectionTableMap[selectedSection] ==
      //               null) {
      //             return Center(
      //                 child: Text('No table data available for this section'));
      //           } else {
      //             List<String> tableNames = splitTableController
      //                 .sectionTableMap[selectedSection]!
      //                 .where((table) =>
      //                 table.tableName.startsWith(
      //                     tableName)) // Filter by table name prefix
      //                 .map((table) => table.tableName)
      //                 .toList();
      //
      //             return Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Padding(
      //                   padding: EdgeInsets.symmetric(vertical: 8.sp,
      //                       horizontal: 16.sp),
      //                   child: Text(
      //                     'Table $tableName Data:',
      //                     // Display header for the table data
      //                     style: TextStyle(
      //                         fontSize: 18.sp, fontWeight: FontWeight.bold),
      //                   ),
      //                 ),
      //                 SizedBox(height: 10.sp),
      //                 // Add some space between header and table names
      //                 ...tableNames.map((tableName) {
      //                   return Padding(
      //                     padding: EdgeInsets.symmetric(
      //                         vertical: 8.sp, horizontal: 16.sp),
      //                     child: Text(
      //                       tableName,
      //                       style: TextStyle(fontSize: 16.sp),
      //                     ),
      //                   );
      //                 }).toList(),
      //               ],
      //             );
      //           }
      //         }),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
// }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:my_hotel/controllers/split_table_controller.dart';
//
// class YourPage extends StatelessWidget {
//   final SplitTableController splitTableController = Get.find<SplitTableController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Selected Table Data'),
//       ),
//       // body: SingleChildScrollView(
//       //   child: Column(
//       //     mainAxisSize: MainAxisSize.min,
//       //     children: [
//       //       Obx(() {
//       //         if (splitTableController.isLoading.value) {
//       //           return Center(child: CircularProgressIndicator());
//       //         } else if (splitTableController.tableData.isEmpty) {
//       //           return Center(child: Text('No table data available'));
//       //         } else {
//       //           List<TableName> tables = splitTableController.getTables();
//       //
//       //           return Column(
//       //             crossAxisAlignment: CrossAxisAlignment.start,
//       //             children: [
//       //               ...tables.map((table) => ListTile(
//       //                 title: Text(table.tableName),
//       //                 trailing: IconButton(
//       //                   icon: Icon(Icons.add),
//       //                   onPressed: () {
//       //                     _showSubTablesDialog(context, table);
//       //                   },
//       //                 ),
//       //               )).toList(),
//       //             ],
//       //           );
//       //         }
//       //       }),
//       //     ],
//       //   ),
//       // ),
//     );
//   }
//
//   // Future<void> _showSubTablesDialog(BuildContext context, TableName table) async {
//   //   List<String> subTables = splitTableController.getSubTables(table.tableName);
//   //
//   //   showDialog(
//   //     context: context,
//   //     builder: (context) {
//   //       return AlertDialog(
//   //         title: Text('Selected Table Data: ${table.tableName}'),
//   //         content: Column(
//   //           mainAxisSize: MainAxisSize.min,
//   //           crossAxisAlignment: CrossAxisAlignment.start,
//   //           children: [
//   //             if (subTables.isNotEmpty) ...[
//   //               Text('Sub-tables:'),
//   //               SizedBox(height: 10),
//   //               ...subTables.map((subTable) => Text(subTable)).toList(),
//   //             ] else ...[
//   //               Text('No sub-tables found for ${table.tableName}'),
//   //             ],
//   //           ],
//   //         ),
//   //         actions: [
//   //           TextButton(
//   //             onPressed: () {
//   //               Navigator.pop(context);
//   //             },
//   //             child: Text('Close'),
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }
// }
