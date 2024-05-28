import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class RegistrationController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> SignUp() async {
    try
    {
      Map<String, dynamic> userData = {
        'username': usernameController.text.trim(),
        'email': emailController.text.trim(),
        'password': passController.text.trim(),
      };
      final Response response = await http.post(
        Uri.parse("http://localhost:5000/api/auth/setup"),
        body: jsonEncode(userData),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('Data Added: $data');
      } else {

        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
  }
}
