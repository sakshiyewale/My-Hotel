import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../api/model/section_model.dart';
import '../controller/order_controller.dart';
import '../controller/split_controller.dart';
import '../utils/app_colors.dart';
import 'menu_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final OrderController orderController = Get.put(OrderController());
  final SplitTableController splitTableController = Get.put(SplitTableController());

  int selectedIndex = 0;
  String? selectedSection;
  int selectedTableIndex = 0;
  String selectedTableName = '';

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    await orderController.getSections();
    if (orderController.sections.isNotEmpty) {
      setState(() {
        selectedSection = orderController.sections.first.name;
      });
      splitTableController.sectionTableMap.value = orderController.sectionTableMap;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F9F2),
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 10.sp),
              child: SizedBox(
                height: 7.h,
                width: 100.w,
                child: Obx(() {
                  if (orderController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (orderController.errorMessage.isNotEmpty) {
                    return Center(child: Text(orderController.errorMessage.value));
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: orderController.sections.length,
                      itemBuilder: (context, index) {
                        return _buildCategoryButton(orderController.sections[index].name, index);
                      },
                    );
                  }
                }),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Obx(() {
              if (orderController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (orderController.errorMessage.isNotEmpty) {
                return Center(child: Text(orderController.errorMessage.value));
              } else {
                return _buildTablesList();
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTablesList() {
    if (selectedSection == null || splitTableController.sectionTableMap[selectedSection] == null) {
      return Center(child: Text('Select a section'));
    } else {
      var tables = splitTableController.sectionTableMap[selectedSection]!;
      return Expanded(
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.sp,
            mainAxisSpacing: 10.sp,
            childAspectRatio: 0.7,
          ),
          itemCount: tables.length,
          itemBuilder: (context, index) {
            return _buildTableWidget(tables[index], index);
          },
        ),
      );
    }
  }

  Widget _buildTableWidget(TableName table, int index) {
    bool isSelected = selectedTableIndex == index;
    Color containerColor = isSelected ? Colors.orangeAccent.shade400 : Color(0xffF0EBE3);

    return GestureDetector(
      onTap: () async {
        setState(() {
          selectedTableIndex = index;
          selectedTableName = table.tableName; // Update selectedTableName
        });
        await _saveSelectedTable(table.tableName);
        Navigator.push(context,MaterialPageRoute(builder: (context)=>AppMenuScreen()));
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
            // Icon(
            //   Icons.dining_sharp,
            //   size: 28,
            //   color: isSelected ? Colors.white : Colors.black,
            // ),
           isSelected? Container(
              child: Image.asset("assets/images/dinner1-removebg-preview.png",height: 10.h,width: 20.w,),
            ):
            Container(
              child: Image.asset("assets/images/dinner-removebg-preview.png",height: 10.h,width: 20.w,),
            ),
            const SizedBox(height: 5),
            Text(
              table.tableName,
              style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w500,color: isSelected ? Colors.white:Colors.black ),
            ),
            Padding(
              padding:EdgeInsets.only(left: 35.sp),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      _showPlusMinusDialog(context, table, isPlus: true); // Show plus dialog
                    },
                    child: Container(
                      height: 4.h,
                      width: 16.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.red),
                      ),
                      child:Center(child: Text("Split",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600),))
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     _showPlusMinusDialog(context, table, isPlus: false); // Show minus dialog
                  //   },
                  //   child: Container(
                  //     height: 5.h,
                  //     width: 10.w,
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(10),
                  //       border: Border.all(color: Colors.black),
                  //     ),
                  //     child: const Icon(Icons.remove, size: 17),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showPlusMinusDialog(BuildContext context, TableName table, {required bool isPlus}) async {
    String dialogTitle = isPlus ? 'Split to table ${table.tableName}' : 'Remove from ${table.tableName}';

    // Fetch selected table data based on `table.tableName`

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(dialogTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             // Text('Selected Table Data:'),
              const SizedBox(height: 10),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text('Selected Section: $selectedSection'),
              //     Text('Table Name: $selectedTableName'),
              //     FloatingActionButton(
              //       backgroundColor: Colors.grey.shade100,
              //       onPressed: () {
              //         // Handle button press if needed
              //       },
              //       child: Icon(Icons.add),
              //     ),
              //   ],
              // ),
              Expanded(
                child: SingleChildScrollView(
                  child: Obx(() {
                    if (splitTableController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else if (splitTableController.sectionTableMap[selectedSection] == null) {
                      return Center(child: Text('No table data available for this section'));
                    } else {
                      List<String> tableNames = splitTableController.sectionTableMap[selectedSection]!
                          .where((table) => table.tableName.startsWith(selectedTableName))
                          .map((table) => table.tableName)
                          .toList();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Table ${table.tableName} Data:',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              FloatingActionButton(onPressed: (){},
                              child: Icon(Icons.add),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          ...tableNames.map((tableName) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              child: Container(
                                height: 20.h,
                                width: 45.w,
                                decoration: BoxDecoration(
                                  color: Colors.orangeAccent.shade400,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color:Colors.grey.shade100
                                  )
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Image.asset("assets/images/dinner1-removebg-preview.png",height: 10.h,width: 20.w,),
                                    ),
                                    Text(
                                      tableName,
                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),
                                    ),
                                    SizedBox(height: 1.h,),
                                    Container(
                                      height: 3.h,
                                      width: 10.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1
                                        )
                                      ),
                                      child: Center(child: Icon(Icons.remove,color: Colors.white,)),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      );
                    }
                  }),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );

  }

  // Future<void> _showPlusMinusDialog(BuildContext context, TableName table, {required bool isPlus}) async {
  //   String dialogTitle = isPlus ? 'Add to ${table.tableName}' : 'Remove from ${table.tableName}';
  //
  //   String selectedSection = ''; // Initialize selectedSection with your logic
  //   String selectedTableName = table.tableName; // Set selectedTableName from the TableName passed
  //
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text(dialogTitle),
  //         content: Expanded(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text('Selected Table Data:'),
  //               const SizedBox(height: 10),
  //               Padding(
  //                 padding: const EdgeInsets.all(10),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text('Selected Section: $selectedSection'),
  //                     Text('Table Name: $selectedTableName'),
  //                     FloatingActionButton(
  //                       backgroundColor: Colors.grey.shade100,
  //                       onPressed: () {
  //                         // Handle button press if needed
  //                       },
  //                       child: Icon(Icons.add),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               SingleChildScrollView(
  //                 child: Obx(() {
  //                   if (splitTableController.isLoading.value) {
  //                     return Center(child: CircularProgressIndicator());
  //                   } else if (splitTableController.sectionTableMap[selectedSection] == null) {
  //                     return Center(child: Text('No table data available for this section'));
  //                   } else {
  //                     List<String> tableNames = splitTableController.sectionTableMap[selectedSection]!
  //                         .where((table) => table.tableName.startsWith(selectedTableName))
  //                         .map((table) => table.tableName)
  //                         .toList();
  //
  //                     return Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Padding(
  //                           padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  //                           child: Text(
  //                             'Table $selectedTableName Data:',
  //                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                         SizedBox(height: 10),
  //                         ...tableNames.map((tableName) {
  //                           return Padding(
  //                             padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  //                             child: Text(
  //                               tableName,
  //                               style: TextStyle(fontSize: 16),
  //                             ),
  //                           );
  //                         }).toList(),
  //                       ],
  //                     );
  //                   }
  //                 }),
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context); // Close the dialog
  //             },
  //             child: Text('Close'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // Future<void> _showPlusMinusDialog(BuildContext context, TableName table, {required bool isPlus}) async {
  //   String dialogTitle = isPlus ? 'Add to ${table.tableName}' : 'Remove from ${table.tableName}';
  //
  //   String selectedSection = ''; // Initialize selectedSection with your logic
  //   String selectedTableName = table.tableName; // Set selectedTableName from the TableName passed
  //
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text(dialogTitle),
  //         content: StatefulBuilder(
  //           builder: (context, setState) {
  //             return Expanded(
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text('Selected Table Data:'),
  //                   const SizedBox(height: 10),
  //                   Padding(
  //                     padding: const EdgeInsets.all(10),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text('Selected Section: $selectedSection'),
  //                         Text('Table Name: $selectedTableName'),
  //                         FloatingActionButton(
  //                           backgroundColor: Colors.grey.shade100,
  //                           onPressed: () {
  //                             // Handle button press if needed
  //                           },
  //                           child: Icon(Icons.add),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   Expanded(
  //                     child: SingleChildScrollView(
  //                       child: Obx(() {
  //                         if (splitTableController.isLoading.value) {
  //                           return Center(child: CircularProgressIndicator());
  //                         } else {
  //                           List<String>? tableNames = splitTableController.getSubTablesForTable(selectedSection, selectedTableName);
  //
  //                           if (tableNames == null) {
  //                             return Center(child: Text('No data available for this table'));
  //                           } else {
  //                             return Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 Padding(
  //                                   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  //                                   child: Text(
  //                                     'Table $selectedTableName Data:',
  //                                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //                                   ),
  //                                 ),
  //                                 SizedBox(height: 10),
  //                                 ...tableNames.map((tableName) {
  //                                   return Padding(
  //                                     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  //                                     child: Text(
  //                                       tableName,
  //                                       style: TextStyle(fontSize: 16),
  //                                     ),
  //                                   );
  //                                 }).toList(),
  //                               ],
  //                             );
  //                           }
  //                         }
  //                       }),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             );
  //           },
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context); // Close the dialog
  //             },
  //             child: Text('Close'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  Future<void> _saveSelectedTable(String tableName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedTableName', tableName);
    setState(() {
      selectedTableName = tableName;
    });
  }

  Widget _buildCategoryButton(String category, int index) {
    bool isSelected = selectedIndex == index;
    Color containerColor = isSelected ? Colors.orangeAccent.shade400 : Colors.white;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          selectedSection = category;
          selectedTableIndex = 0;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? Colors.orangeAccent : Colors.black),
          borderRadius: BorderRadius.circular(5),
          color: containerColor,
        ),
        child: Text(
          category,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
