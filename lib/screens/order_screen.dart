import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_hotel/controller/order_controller.dart';
import 'package:sizer/sizer.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
OrderController orderController =Get.find();
int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // FutureBuilder(
          //     future: orderController.getApi(),
          //     builder: (context,snapshot)
          // {
          //   if(snapshot.connectionState==ConnectionState.waiting)
          //     {
          //       return Center(child: CircularProgressIndicator());
          //     }
          //   else{
          //     return Expanded(
          //       child: ListView.builder(
          //           itemCount: orderController.data.length,
          //           itemBuilder: (context,index)
          //
          //       {
          //         bool isSelected = selectedIndex==0;
          //         return Row(
          //           children: [
          //             Padding(
          //               padding: EdgeInsets.all(8.0),
          //               child: Container(
          //                 height: 6.5.h,
          //                 width: 36.w,
          //                 decoration: BoxDecoration(
          //                   color: isSelected
          //                       ? Colors.white
          //                       : Colors.white,
          //                   borderRadius: BorderRadius.circular(15),
          //                   border: Border.all(color: Colors.grey, width: 2),
          //                 ),
          //                 child: Row(
          //                   children: [
          //                     GestureDetector(
          //                       child: Padding(
          //                         padding: EdgeInsets.only(left: 10.sp),
          //                         child: Container(
          //                           decoration: BoxDecoration(
          //                               borderRadius:
          //                               BorderRadius.circular(50),
          //                               color: isSelected
          //                                   ? Colors.orange
          //                                   : Colors.white,
          //                               border: Border.all(
          //                                   color: isSelected
          //                                       ? Colors.orange
          //                                       : Colors.grey,
          //                                   width: 2)),
          //                           height: 2.3.h,
          //                           width: 4.6.w,
          //                         ),
          //                       ),
          //                       onTap: () {
          //                         setState(() {
          //                           selectedIndex = 0;
          //                         });
          //                       },
          //                     ),
          //                     Padding(
          //                       padding: EdgeInsets.only(left: 7.sp),
          //                       child: Text(orderController.data[index]["name"].toString()), // Display item from the list
          //                     )
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ],
          //         );
          //       }),
          //     );
          //   }
          // })
          Container(
            height: 10.h,
            width: 100.w,
            child: FutureBuilder(
              future: orderController.getApi(),
              builder: (context,snapshot)
              {
                if(snapshot.connectionState==ConnectionState.waiting)
                  {
                    return CircularProgressIndicator();
                  }
                else{
                  return Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount:orderController.data.length, // Use the length of items list
                      itemBuilder: (context, index) {
                        bool isSelected = selectedIndex==0;
                        return Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                height: 6.5.h,
                                width: 30.w,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.grey, width: 2),
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.sp),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(50),
                                              color: isSelected
                                                  ? Colors.orange
                                                  : Colors.white,
                                              border: Border.all(
                                                  color: isSelected
                                                      ? Colors.orange
                                                      : Colors.grey,
                                                  width: 2)),
                                          height: 2.3.h,
                                          width: 4.6.w,
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = 0;
                                        });
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 7.sp),
                                      child: Text(orderController.data[index]['name'].toString()) // Dsplay item from the list
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }
              },
            )
          ),
        ],
      ),
    );
  }
}




