//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:my_hotel/screens/order_screen.dart';
// import 'package:sizer/sizer.dart';
// class MenuScreen1 extends StatefulWidget {
//   const MenuScreen1({super.key});
//   @override
//   State<MenuScreen1> createState() => _MenuScreen1State();
// }
// class _MenuScreen1State extends State<MenuScreen1> {
//   late MenuController menuController;
//   int selectedIndexone = 0;
//   int selectedIndex = 0;
//   int selectedtwoIndex = 0;
//   bool abc = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize LoginController here
//     menuController = Get.put(MenuController());
//   }
//
//   List<String> items = [
//     'Pub',
//     'Terrace',
//     'Garden',
//     'VIP Room'
//   ];
//   List<String> items1 =
//   [
//     '1',
//     '2',
//     '3',
//     '4',
//     '5',
//     '6',
//     '7',
//     '8',
//     '9',
//     '10'
//   ];
//   String selectedCategory = 'Chicken';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding:  EdgeInsets.symmetric(horizontal: 5.sp),
//         child: SafeArea(
//           child: Column(
//             children: [
//               SizedBox(height: 2.5.h,),
//               Container(
//                 height: 10.h,
//                 width: 100.w,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   shrinkWrap: true,
//                   itemCount: items.length, // Use the length of items list
//                   itemBuilder: (context, index) {
//                     bool isSelected = false;
//                     return Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Container(
//                             height: 6.5.h,
//                             width: 36.w,
//                             decoration: BoxDecoration(
//                               color: selectedIndex == index
//                                   ? Colors.white
//                                   : Colors.white,
//                               borderRadius: BorderRadius.circular(15),
//                               border: Border.all(color: Colors.grey, width: 2),
//                             ),
//                             child: Row(
//                               children: [
//                                 GestureDetector(
//                                   child: Padding(
//                                     padding: EdgeInsets.only(left: 10.sp),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                           BorderRadius.circular(50),
//                                           color: selectedIndex == index
//                                               ? Colors.orange
//                                               : Colors.white,
//                                           border: Border.all(
//                                               color: selectedIndex == index
//                                                   ? Colors.orange
//                                                   : Colors.grey,
//                                               width: 2)),
//                                       height: 2.3.h,
//                                       width: 4.6.w,
//                                     ),
//                                   ),
//                                   onTap: () {
//                                     setState(() {
//                                       selectedIndex = index;
//                                     });
//                                   },
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(left: 7.sp),
//                                   child: Text(items[index]), // Display item from the list
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//               Container(
//                 height: 10.h,
//                 width: 100.w,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   shrinkWrap: true,
//                   itemCount: 10,
//                   itemBuilder: (context, index) {
//                     return Row(
//                       children: [
//                         Padding(
//                           padding:EdgeInsets.only(top: 6.sp,left: 8.sp),
//                           child: GestureDetector(
//                             child: Container(
//                               height: 10.h,
//                               width: 25.w,
//                               decoration:  BoxDecoration(
//                                   color: selectedtwoIndex == index
//                                       ? Colors.orangeAccent
//                                       : Colors.white,
//                                   borderRadius: BorderRadius.circular(15),
//                                   // boxShadow: [
//                                   //   BoxShadow(
//                                   //     color: Colors.grey,
//                                   //     blurRadius: 1,
//                                   //     offset:Offset(1, 1),
//                                   //     spreadRadius: 1,
//                                   //   ),
//                                   // ],
//                                   border: Border.all(color:selectedtwoIndex==index
//                                       ? Colors.orangeAccent
//                                       : Colors.grey ,
//                                       width: 2)
//                               ),
//                               child: Column(
//                                 children: [
//                                   Padding(
//                                     padding:  EdgeInsets.only(top: 4.sp,right: 35.sp),
//                                     // child: Text("1",style: TextStyle(fontWeight: FontWeight.w700),),
//                                     child: Text(items1[index],style: TextStyle(fontWeight: FontWeight.w700,color: selectedtwoIndex==index
//                                         ? Colors.white
//                                         : Colors.black,),),
//                                   ),
//                                   Container(
//                                     height: 1.h,
//                                     width: 8.w,
//                                     child: Icon(Icons.dining_sharp,size: 28.sp,
//                                       color: selectedtwoIndex==index
//                                           ? Colors.white
//                                           : Colors.black,
//                                     ),
//                                   ),
//                                   //Text("\$706",style: TextStyle(fontWeight: FontWeight.w500),)
//                                 ],
//                               ),
//                             ),
//                             onTap: (){
//                               setState(() {
//                                 selectedtwoIndex = index;
//                               });
//
//                             },
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(height: 1.5.h,),
//
//               Expanded(
//                 child: Padding(
//                   padding:  EdgeInsets.only(top:  10.sp),
//                   child: Container(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 _buildCategoryButton('Chicken'),
//                                 _buildCategoryButton('Kabab'),
//                                 _buildCategoryButton('Rice'),
//                                 _buildCategoryButton('Soup'),
//                                 _buildCategoryButton('Veg'),
//                               ],
//                             ),
//                             SizedBox(height: 1.5.h,),
//                             Container(
//                               height: 5.5.h,
//                               child: TextFormField(
//                                 decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(11)
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(11)
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(11)
//                                     ),
//                                     labelText: "Search Menu / id....",
//                                     suffixIcon: Icon(Icons.search,color: Colors.black,)
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 0.5.sp,),
//                           ],
//                         ),
//
//                         // Display different body based on the selection
//                         selectedCategory == 'Chicken'
//                             ? _Chicken()
//                             : selectedCategory == 'Kabab'
//                             ? _Kabab()
//                             : selectedCategory == 'Rice'
//                             ? _Rice()
//                             : selectedCategory == 'Soup'
//                             ? _Soup()
//                             :selectedCategory =='Veg'
//                             ? _Veg()
//                             : Container(), // Return an empty container if category not found
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//
//
//               // SizedBox(height: 3.w,),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   Widget _Chicken() {
//     return Expanded(
//       child: GridView.builder(
//         shrinkWrap: true,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 2),
//         itemCount: 30,
//         itemBuilder: (context, index) {
//           return Row(
//             children: [
//               GestureDetector(
//                 child: Padding(
//                   padding: EdgeInsets.only(top: 10.sp, left: 8.sp),
//                   child: Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(15),
//                         border: Border.all(color: Colors.grey, width: 2),
//                       ),
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(top: 10.sp, left: 10.sp),
//                                 child: Text(
//                                   "100",
//                                   style: TextStyle(
//                                     color: Colors.red,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 10.sp, left: 60.sp,right: 15),
//                                 child: Text(
//                                   "\$100",
//                                   style: TextStyle(
//                                     color: Colors.green,
//                                     fontWeight: FontWeight.w800,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(left: 10.sp, top: 3.sp),
//                                 child: Text(
//                                   "Veg Manchow Soup",
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 onTap: () {
//                   Get.to(OrderScreen());
//                 },
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//   Widget  _Kabab() {
//     return Expanded(
//       child: GridView.builder(
//         shrinkWrap: true,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 2),
//         itemCount: 30,
//         itemBuilder: (context, index) {
//           return Row(
//             children: [
//               GestureDetector(
//                 child: Padding(
//                   padding: EdgeInsets.only(top: 10.sp, left: 8.sp),
//                   child: Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(15),
//                         border: Border.all(color: Colors.grey, width: 2),
//                       ),
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(top: 10.sp, left: 10.sp),
//                                 child: Text(
//                                   "200",
//                                   style: TextStyle(
//                                     color: Colors.red,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 10.sp, left: 60.sp,right: 15),
//                                 child: Text(
//                                   "\$200",
//                                   style: TextStyle(
//                                     color: Colors.green,
//                                     fontWeight: FontWeight.w800,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(left: 10.sp, top: 3.sp),
//                                 child: Text(
//                                   "Kabab",
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 onTap: () {
//                   Get.to(OrderScreen());
//                 },
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//   Widget  _Rice() {
//     return Expanded(
//       child: GridView.builder(
//         shrinkWrap: true,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 2),
//         itemCount: 30,
//         itemBuilder: (context, index) {
//           return Row(
//             children: [
//               GestureDetector(
//                 child: Padding(
//                   padding: EdgeInsets.only(top: 10.sp, left: 8.sp),
//                   child: Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(15),
//                         border: Border.all(color: Colors.grey, width: 2),
//                       ),
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(top: 10.sp, left: 10.sp),
//                                 child: Text(
//                                   "300",
//                                   style: TextStyle(
//                                     color: Colors.red,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 10.sp, left: 60.sp,right: 15),
//                                 child: Text(
//                                   "\$300",
//                                   style: TextStyle(
//                                     color: Colors.green,
//                                     fontWeight: FontWeight.w800,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(left: 10.sp, top: 3.sp),
//                                 child: Text(
//                                   "Rice",
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 onTap: () {
//                   Get.to(OrderScreen());
//                 },
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//   Widget  _Soup() {
//     return Expanded(
//       child: GridView.builder(
//         shrinkWrap: true,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 2),
//         itemCount: 30,
//         itemBuilder: (context, index) {
//           return Row(
//             children: [
//               GestureDetector(
//                 child: Padding(
//                   padding: EdgeInsets.only(top: 10.sp, left: 8.sp),
//                   child: Container(
//                     height: 9.h,
//                     width: 45.w,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(15),
//                       border: Border.all(color: Colors.grey, width: 2),
//                     ),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(top: 10.sp, left: 10.sp),
//                               child: Text(
//                                 "400",
//                                 style: TextStyle(
//                                   color: Colors.red,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(top: 10.sp, left: 60.sp),
//                               child: Text(
//                                 "\$400",
//                                 style: TextStyle(
//                                   color: Colors.green,
//                                   fontWeight: FontWeight.w800,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(left: 10.sp, top: 3.sp),
//                               child: Text(
//                                 "Soup",
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 onTap: () {
//                   Get.to(OrderScreen());
//                 },
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//   Widget  _Veg() {
//     return Expanded(
//       child: GridView.builder(
//         shrinkWrap: true,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 2),
//         itemCount: 30,
//         itemBuilder: (context, index) {
//           return Row(
//             children: [
//               GestureDetector(
//                 child: Padding(
//                   padding: EdgeInsets.only(top: 10.sp, left: 8.sp),
//                   child: Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(15),
//                         border: Border.all(color: Colors.grey, width: 2),
//                       ),
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(top: 10.sp, left: 10.sp),
//                                 child: Text(
//                                   "500",
//                                   style: TextStyle(
//                                     color: Colors.red,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 10.sp, left: 60.sp,right: 15),
//                                 child: Text(
//                                   "\$500",
//                                   style: TextStyle(
//                                     color: Colors.green,
//                                     fontWeight: FontWeight.w800,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(left: 10.sp, top: 3.sp),
//                                 child: Text(
//                                   "Veg",
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 onTap: () {
//                   Get.to(OrderScreen());
//                 },
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//   Widget _buildCategoryButton(String category) {
//     Color containerColor = selectedCategory == category
//         ? Colors.orangeAccent
//         : Colors.white;
//
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedCategory = category;
//         });
//       },
//       child: Container(
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           border: Border.all(color: selectedCategory==category
//               ? Colors.orangeAccent
//               : Colors.black,
//           ),
//           borderRadius: BorderRadius.circular(5),
//           color: containerColor,
//         ),
//         child: Text(
//           category,
//           style: TextStyle(
//             fontSize: 10.sp,
//             fontWeight: FontWeight.w500,
//             color: selectedCategory == category
//                 ? Colors.white
//                 : Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }
