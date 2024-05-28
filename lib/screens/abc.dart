// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
//
// import '../controller/login_controller.dart';
// import '../widgets/text_field.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   LoginController loginController = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SafeArea(
//             child: Hero(
//               tag: 'logo', // Same unique tag for the hero animation
//               child: Container(
//                 height: 35.h,
//                 width: 100.w,
//                 decoration: BoxDecoration(
//                   //color: Colors.grey,
//                   image: DecorationImage(
//                     image: AssetImage("assets/images/logo1-Photoroom.png-Photoroom.png"),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 1.h,
//           ),
//           Text(
//             "Login Now ",
//             style: TextStyle(fontWeight: FontWeight.w700, fontSize: 29.sp),
//           ),
//           Form(
//             child: Column(
//               children: [
//                 CustomTextField(
//                   controller: loginController.usernameController,
//                   hintText: "Username",
//                   validator: (value) {},
//                 ),
//                 SizedBox(height: 1.h),
//                 CustomTextField(
//                   controller: loginController.passController,
//                   hintText: "Password",
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
