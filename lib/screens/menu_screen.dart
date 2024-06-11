import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_hotel/controller/menu_controller.dart';
import 'package:my_hotel/widgets/text_field.dart';
import 'package:sizer/sizer.dart';
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
  Map<dynamic, int> itemQuantities = {};
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
  }

  @override
  void dispose() {
    searchController.dispose();
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

  void increaseQuantity(dynamic menuItem) {
    setState(() {
      itemQuantities.update(menuItem, (value) => value + 1, ifAbsent: () => 1);
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
      }
    });
  }

  void updateQuantity(dynamic menuItem, String quantityText) {
    int? quantity = int.tryParse(quantityText);
    if (quantity != null && quantity > 0) {
      setState(() {
        itemQuantities[menuItem] = quantity;
      });
    } else {
      // Handle invalid input here, for now, let's just remove the item
      setState(() {
        itemQuantities.remove(menuItem);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                SizedBox(height: 3.h,),
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
                        suffixIcon: Icon(Icons.search, color: Colors.black,),
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
                        childAspectRatio: 1.sp,
                      ),
                      itemCount: filteredMenuItems.length,
                      itemBuilder: (context, index) {
                        TextEditingController quantityController = TextEditingController();

                        quantityController.text = itemQuantities[filteredMenuItems[index]]?.toString() ?? '';

                        quantityController.addListener(() {
                          String newText = quantityController.text;
                          if (newText.startsWith('0') && newText.length > 1) {
                            newText = newText.substring(0);
                            quantityController.value = TextEditingValue(
                              text: newText,
                              selection: TextSelection.collapsed(offset: newText.length),
                            );
                          }
                          updateQuantity(filteredMenuItems[index], newText);
                        });

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedMenuItemIndex = index;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
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
                                      padding: EdgeInsets.only(right: 3.sp, left: 60.sp),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Icon(Icons.currency_rupee, color: Colors.green, size: 11.sp,),
                                          Text(
                                            'Price: ${filteredMenuItems[index]['price']}',
                                            style: TextStyle(fontSize: 9.sp, color: Colors.green),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h),
                                Center(
                                  child: Text(
                                    filteredMenuItems[index]['name'],
                                    style: TextStyle(fontSize: 9.sp, color: Colors.black),
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () {
                                          increaseQuantity(filteredMenuItems[index]);
                                        },
                                      ),
                                      Container(
                                        height: 5.h,
                                        child: CustomTextField(
                                          width: 15.w,
                                          hintText: "Quantity",
                                          controller: quantityController,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () {
                                          decreaseQuantity(filteredMenuItems[index]);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    height: 25.h,
                    width: 100.w,
                    child: ListView.builder(
                      itemCount: itemQuantities.length,
                      itemBuilder: (context, index) {
                        var menuItem = itemQuantities.keys.elementAt(index);
                        var quantity = itemQuantities[menuItem];
                        return ListTile(
                          title: Text(
                            '${menuItem['name']} - Quantity: $quantity',
                            style: TextStyle(fontSize: 10.sp, color: Colors.orange),
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
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => KOTScreen(selectedItems: itemQuantities,)));
                        Get.to(KOTScreen(selectedItems: itemQuantities));
                      },
                      child: Container(
                        height: 6.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text("KOT", style: TextStyle(
                            color: Colors.white,
                          ),),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        height: 6.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text("Re-KOT", style: TextStyle(
                            color: Colors.white,
                          ),),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildCategoryButton(String category, int index) {
    bool isSelected = selectedIndex == index;
    Color containerColor = isSelected ? Colors.orangeAccent : Colors.white;

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
