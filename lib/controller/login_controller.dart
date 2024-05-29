import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../utils/app_colors.dart';

class LoginController extends GetxController
{
TextEditingController usernameController =TextEditingController();
TextEditingController passController =TextEditingController();
final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
// Future<void> SignIn() async {
//   try
//   {
//     Map<String, dynamic> userData = {
//       'username': usernameController.text.trim(),
//       'password': passController.text.trim(),
//     };
//     final response = await http.post(
//       Uri.parse("http://localhost:5000/api/auth/login"),
//       body: jsonEncode(userData),
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//     );
//
//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       print('Sign in: $data');
//     } else {
//
//       print('Error: ${response.statusCode}');
//     }
//   } catch (error) {
//     print('Error occurred: $error');
//   }
// }
  Future<bool> signIn(BuildContext context) async {
    try {
      Map<String, dynamic> userData = {
        'username': usernameController.text.trim(),
        'password': passController.text.trim(),
      };

      final http.Response response = await http.post(
        Uri.parse("http://localhost:5000/api/auth/login"),
        body: jsonEncode(userData),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('Data Added: $data');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: ColorsForApp.loginButtonColor,
            content: Text('Login Successfully'),
          ),
        );
        return true;
      } else {
        print('Error: ${response.statusCode}');
        var errorData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(' Login Failed: ${errorData['message']}'),
          ),
        );
        return false;
      }
    } catch (error) {
      print('Error occurred: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('An error occurred. Please try again.'),
        ),
      );
      return false;
    }
  }
}