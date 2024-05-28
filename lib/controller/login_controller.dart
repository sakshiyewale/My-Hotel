import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController
{
TextEditingController usernameController =TextEditingController();
TextEditingController passController =TextEditingController();
final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
}