import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:my_hotel/utils/app_colors.dart';

class RegistrationController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<bool> signUp(BuildContext context) async {
    try {
      Map<String, dynamic> userData = {
        'username': usernameController.text.trim(),
        'email': emailController.text.trim(),
        'password': passController.text.trim(),
      };

      final http.Response response = await http.post(
        Uri.parse("http://localhost:5000/api/auth/setup"),
        body: jsonEncode(userData),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 400) {
        var data = jsonDecode(response.body);
        print('Data Added: $data');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: ColorsForApp.loginButtonColor,
            content: Text('Registration Successful'),
          ),
        );
        return true;
      } else {
        print('Error: ${response.statusCode}');
        var errorData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Registration Failed: ${errorData['message']}'),
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
