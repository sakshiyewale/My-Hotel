import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_hotel/controller/menu_controller.dart';
import 'package:my_hotel/widgets/text_field.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/app_colors.dart';
import 'kot_screen.dart';

class AppMenuScreen extends StatefulWidget {
  const AppMenuScreen({Key? key}) : super(key: key);

  @override
  State<AppMenuScreen> createState() => _AppMenuScreenState();
}

class _AppMenuScreenState extends State<AppMenuScreen> {
  AppMenuController appMenuController = Get.put(AppMenuController());
  int selectedIndex = 0;
  String selectedSection = '';
  List<dynamic> menuItems = [];
  List<dynamic> filteredMenuItems = [];
  Map<dynamic, TextEditingController> itemControllers = {};
  TextEditingController searchController = TextEditingController();
  int? selectedMenuItemIndex;

  @override
  void initState() {
    super.initState();
    appMenuController.fetchCategories().then((_) {
      if (appMenuController.categories.isNotEmpty) {
        fetchMenuItems(appMenuController.categories[0]['name']);
      }
    });
    searchController.addListener(_filterMenuItems);
    // Load item quantities from shared preferences on app startup
    _loadItemQuantities();
  }

  @override
  void dispose() {
    searchController.dispose();
    for (var controller in itemControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void fetchMenuItems(String category) async {
    setState(() {
      menuItems = [];
    });
    List<dynamic> items = await appMenuController.fetchMenuByCategory(category);
    setState(() {
      menuItems = items;
      filteredMenuItems = items;
      itemControllers.clear();
      for (var item in filteredMenuItems) {
        itemControllers[item] = TextEditingController(
          text: itemQuantities[item]?.toString() ?? '0',
        );
      }
    });
  }

  void _filterMenuItems() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredMenuItems = menuItems.where((item) {
        String name = item['name'].toLowerCase();
        String id = item['id'].toString();
        return name.contains(query) || id.contains(query);
      }).toList();
    });
  }

  Map<dynamic, int> itemQuantities = {};

  void _loadItemQuantities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('itemQuantities');
    if (jsonData != null) {
      setState(() {
        itemQuantities = Map<dynamic, int>.from(json.decode(jsonData));
      });
    }
  }

  void _saveItemQuantities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = json.encode(itemQuantities);
    prefs.setString('itemQuantities', jsonData);
  }

  void increaseQuantity(dynamic menuItem) {
    setState(() {
      itemQuantities.update(menuItem, (value) => value + 1, ifAbsent: () => 1);
      itemControllers[menuItem]!.text = itemQuantities[menuItem]!.toString();
      _saveItemQuantities(); // Save updated quantities to shared preferences
    });
  }

  void decreaseQuantity(dynamic menuItem) {
    setState(() {
      if (itemQuantities.containsKey(menuItem)) {
        if (itemQuantities[menuItem]! > 1) {
          itemQuantities.update(menuItem, (value) => value - 1);
        } else {
          itemQuantities.remove(menuItem);
        }
        itemControllers[menuItem]!.text = itemQuantities[menuItem]?.toString() ?? '0';
        _saveItemQuantities(); // Save updated quantities to shared preferences
      }
    });
  }

  void updateQuantity(dynamic menuItem, String quantityText) {
    int? quantity = int.tryParse(quantityText);
    if (quantity != null && quantity > 0) {
      setState(() {
        itemQuantities[menuItem] = quantity;
        itemControllers[menuItem]!.text = quantity.toString(); // Update text field in main screen
        _saveItemQuantities(); // Save updated quantities to shared preferences
      });
    } else {
      setState(() {
        itemQuantities.remove(menuItem);
        _saveItemQuantities(); // Save updated quantities to shared preferences
      });
    }
  }

  // void _showItemDetailsBottomSheet() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return SingleChildScrollView(
  //         child: Container(
  //           height: MediaQuery.of(context).size.height * 0.7, // Adjust the height as needed, here 70% of screen height
  //           width: MediaQuery.of(context).size.width,
  //           child: ListView.builder(
  //             itemCount: itemQuantities.length,
  //             itemBuilder: (context, index) {
  //               var menuItem = itemQuantities.keys.elementAt(index);
  //               var quantity = itemQuantities[menuItem];
  //
  //               // ListTile showing the selected items with quantity
  //               return ListTile(
  //                 title: Text(
  //                   '${menuItem['name']} - Quantity: $quantity',
  //                   style: TextStyle(fontSize: 14.sp, color: Colors.deepOrange),
  //                 ),
  //                 subtitle: Center(
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       IconButton(
  //                         icon: Icon(Icons.delete, color: Colors.red),
  //                         onPressed: () {
  //                           setState(() {
  //                             itemQuantities.remove(menuItem);
  //                             _saveItemQuantities(); // Save updated quantities to shared preferences
  //                           });
  //                           Navigator.pop(context); // Close bottom sheet
  //                         },
  //                       ),
  //                       SizedBox(width: 5.w),
  //                       IconButton(
  //                         icon: Icon(Icons.edit, color: Colors.blue),
  //                         onPressed: () {
  //                           Navigator.pop(context); // Close bottom sheet
  //                           _showEditQuantityDialog(menuItem);
  //                         },
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }


  // void _showItemDetailsBottomSheet() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return SingleChildScrollView(
  //         child: Container(
  //           height: MediaQuery.of(context).size.height * 0.7,
  //           width: MediaQuery.of(context).size.width,
  //           child: ListView.builder(
  //             itemCount: itemQuantities.length,
  //             itemBuilder: (context, index) {
  //               var menuItem = itemQuantities.keys.elementAt(index);
  //               var quantity = itemQuantities[menuItem];
  //
  //               return Dismissible(
  //                 key: Key('$menuItem'), // Unique key for each Dismissible
  //                 direction: DismissDirection.endToStart, // Swipe from left to right
  //                 background: Container(
  //                   color: Colors.red,
  //                   alignment: Alignment.centerLeft,
  //                   padding: EdgeInsets.symmetric(horizontal: 20),
  //                   child: Icon(Icons.delete, color: Colors.white),
  //                 ),
  //                 onDismissed: (direction) {
  //                   setState(() {
  //                     itemQuantities.remove(menuItem);
  //                     _saveItemQuantities(); // Save updated quantities to shared preferences
  //                   });
  //                   ScaffoldMessenger.of(context).showSnackBar(
  //                     SnackBar(
  //                       content: Text('${menuItem['name']} deleted'),
  //                       action: SnackBarAction(
  //                         label: 'Undo',
  //                         onPressed: () {
  //                           // Implement undo logic if needed
  //                           // You can restore the item here
  //                           // itemQuantities[menuItem] = previousQuantity;
  //                           // _saveItemQuantities();
  //                         },
  //                       ),
  //                     ),
  //                   );
  //                 },
  //                 child: ListTile(
  //                   title: Text(
  //                     '${menuItem['name']} - Quantity: $quantity',
  //                     style: TextStyle(fontSize: 14.sp, color: Colors.deepOrange),
  //                   ),
  //                   subtitle: Center(
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         IconButton(
  //                           icon: Icon(Icons.edit, color: Colors.blue),
  //                           onPressed: () {
  //                             Navigator.pop(context); // Close bottom sheet
  //                             _showEditQuantityDialog(menuItem);
  //                           },
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }



  void _showItemDetailsBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: itemQuantities.length,
              itemBuilder: (context, index) {
                var menuItem = itemQuantities.keys.elementAt(index);
                var quantity = itemQuantities[menuItem];

                return Dismissible(
                  key: Key('$menuItem'), // Unique key for each Dismissible
                  direction: DismissDirection.horizontal,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.blue,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.edit, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      // Edit action
                      _showEditQuantityDialog(menuItem);
                      return false; // Prevent Dismissible from being dismissed
                    } else if (direction == DismissDirection.startToEnd) {
                      // Delete action
                      setState(() {
                        itemQuantities.remove(menuItem);
                        _saveItemQuantities(); // Save updated quantities to shared preferences
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${menuItem['name']} deleted'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // Implement undo logic if needed
                              // You can restore the item here
                              // itemQuantities[menuItem] = previousQuantity;
                              // _saveItemQuantities();
                            },
                          ),
                        ),
                      );
                      return true; // Dismiss Dismissible after deletion
                    }
                    return false;
                  },
                  child: ListTile(
                    title: Text(
                      '${menuItem['name']} - Quantity: $quantity',
                      style: TextStyle(fontSize: 14.sp, color: Colors.deepOrange),
                    ),
                    // subtitle: Center(
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       IconButton(
                    //         icon: Icon(Icons.edit, color: Colors.blue),
                    //         onPressed: () {
                    //           _showEditQuantityDialog(menuItem);
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }


  void _showEditQuantityDialog(dynamic menuItem) {
    TextEditingController quantityController = TextEditingController(
      text: itemQuantities[menuItem]?.toString() ?? '0',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Quantity'),
        content: TextFormField(
          controller: quantityController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Quantity'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              String newQuantity = quantityController.text;
              updateQuantity(menuItem, newQuantity);
              Navigator.pop(context); // Close dialog
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _updateQuantityInMenu(dynamic menuItem, int newQuantity) {
    setState(() {
      itemQuantities[menuItem] = newQuantity;
      itemControllers[menuItem]!.text = newQuantity.toString();
      _saveItemQuantities(); // Save updated quantities to shared preferences
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F9F2),
      body: Obx(() {
        if (appMenuController.categories.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          return SafeArea(
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      appMenuController.categories.length,
                          (index) {
                        return _buildCategoryButton(
                          appMenuController.categories[index]['name'].toString(),
                          index,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Container(
                    height: 5.5.h,
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                        labelText: "Search Menu / id....",
                        suffixIcon: Icon(Icons.search, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 100.h,
                    width: 100.w,
                    child: GridView.builder(
                      padding: EdgeInsets.all(10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.9.sp,
                      ),
                      itemCount: filteredMenuItems.length,
                      itemBuilder: (context, index) {
                        var menuItem = filteredMenuItems[index];
                        var quantityController = itemControllers[menuItem]!;

                        quantityController.addListener(() {
                          String newText = quantityController.text;
                          if (newText.startsWith('0') && newText.length > 1) {
                            newText = newText.substring(1);
                            quantityController.value = TextEditingValue(
                              text: newText,
                              selection: TextSelection.collapsed(offset: newText.length),
                            );
                          }
                          updateQuantity(menuItem, newText);
                        });

                        // Container for each menu item
                        return Container(
                          decoration: BoxDecoration(
                            color: Color(0xffF0EBE3),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 58.sp, top: 8.sp),
                                    child: Row(
                                      children: [
                                        Icon(Icons.currency_rupee_sharp, color: Color(0xff25b309), size: 12.sp),
                                        Text(
                                          'Price: ${filteredMenuItems[index]['price']}',
                                          style: TextStyle(fontSize: 12.sp, color: Color(0xff25b309)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 3.h),
                              Center(
                                child: Text(
                                  filteredMenuItems[index]['name'],
                                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: Color(0xff6b0606)),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Padding(
                                padding: EdgeInsets.only(left: 14.sp),
                                child: Container(
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.add, color: Colors.blue),
                                        onPressed: () {
                                          increaseQuantity(menuItem);
                                        },
                                      ),
                                      Container(
                                        height: 5.h,
                                        child: CustomTextField(
                                          width: 13.w,
                                          hintText: "Quantity",
                                          controller: quantityController,
                                          borderColor: Colors.purple,
                                          focusedBorderColor: Colors.purpleAccent,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.remove, color: Colors.blue),
                                        onPressed: () {
                                          decreaseQuantity(menuItem);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showItemDetailsBottomSheet(); // Show bottom sheet
                      },
                      child: Container(
                        height: 5.5.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: ColorsForApp.loginButtonColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "View",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12.sp),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KOTScreen(
                              selectedItems: itemQuantities,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 5.5.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: ColorsForApp.loginButtonColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "KOT",
                            style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 5.5.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: ColorsForApp.loginButtonColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Re-KOT",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildCategoryButton(String category, int index) {
    bool isSelected = selectedIndex == index;
    Color containerColor = isSelected ? Colors.orangeAccent.shade400 : Colors.white;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          selectedSection = category;
        });
        fetchMenuItems(category);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? Colors.orangeAccent : Colors.black),
          borderRadius: BorderRadius.circular(5),
          color: containerColor,
        ),
        child: Text(
          category,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
