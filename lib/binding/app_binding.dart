import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_hotel/controller/history_controller.dart';
import 'package:my_hotel/controller/login_controller.dart';
import 'package:my_hotel/controller/order_controller.dart';
import 'package:my_hotel/controller/registration_controller.dart';
import 'package:my_hotel/controller/splash_controller.dart';

class LoginBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}

class HistoryBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => HistoryController());
  }
}

class MenuBindings extends Bindings
{
  @override
  void dependencies() {
   Get.lazyPut(() => MenuController());
  }
}

class OrderBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => OrderController());
  }
}


class SplashBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }

}

class RegistrationBinding extends Bindings
{
  @override
  void dependencies() {
  Get.lazyPut(() => RegistrationController());
  }

}