import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_hotel/controller/connectivity_controller.dart';
import 'package:my_hotel/controller/history_controller.dart';
import 'package:my_hotel/controller/kot_controller.dart';
import 'package:my_hotel/controller/login_controller.dart';
import 'package:my_hotel/controller/menu_controller.dart';
import 'package:my_hotel/controller/order_controller.dart';
import 'package:my_hotel/controller/registration_controller.dart';
import 'package:my_hotel/controller/splash_controller.dart';

import '../controller/split_controller.dart';


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

class AppMenuBinding extends Bindings
{
  @override
  void dependencies() {
  Get.lazyPut(() => AppMenuController());
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

class KOTScreenBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => KOTScreenController());
  }

}

class ConnectivityBinding extends Bindings
{
  @override
  void dependencies() {
   Get.lazyPut(() => ConnectivityController());
  }

}

class SplitTableBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => SplitTableController());
  }

}