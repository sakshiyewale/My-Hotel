import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_hotel/screens/menu_screen.dart';
import 'package:my_hotel/screens/order_screen.dart';

import '../widgets/constant_widgets.dart'; // Assuming this import is correct and includes 'Routes'

class ConnectivityController extends GetxController {
  RxBool isInternetAvailable = true.obs; // Initialize isInternetAvailable as a RxBool
  Connectivity connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? streamSubscription;

  @override
  void onInit() async {
    super.onInit();
    try {
      List<ConnectivityResult> connectivityResult = await connectivity.checkConnectivity();
      isInternetAvailable.value = connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi;
      callStreamSubscription();
    } on PlatformException catch (e) {
      errorSnackBar(message: e.message);
    }
  }

  @override
  void onClose() {
    streamSubscription?.cancel();
    super.onClose();
  }

  callStreamSubscription() {
    streamSubscription = connectivity.onConnectivityChanged.listen((ConnectivityResult connectivityResult) {
      try {
        print('###1');
        if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
          print('###2');

          isInternetAvailable.value = true;
          print('###3');

          log('🛜 => 🟢');
        } else if (connectivityResult == ConnectivityResult.none)
        {
          print('###0');

          isInternetAvailable.value = false;
          log('🛜 => 🔴');
        } else {
          throw Exception('Network Error, Try after sometime!');
        }

        if (isInternetAvailable.value) {
          Get.to(OrderScreen());
        } else {
          // Get.toNamed(Routes.NO_INTERNET_CONNECTION_SCREEN);
          // Assuming Routes is defined correctly
          Get.to(AppMenuScreen());
        }
      } catch (e) {
        errorSnackBar(message: e.toString());
      }
    } as void Function(List<ConnectivityResult> event)?) as StreamSubscription<ConnectivityResult>?;
  }
}
