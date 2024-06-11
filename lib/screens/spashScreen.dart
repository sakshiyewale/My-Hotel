import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  // late AnimationController _animationController;
  // late Animation<double> _fadeAnimation;
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   _animationController = AnimationController(
  //     vsync: this,
  //     duration: Duration(milliseconds: 800), // Adjust duration as needed
  //   );
  //
  //
  //   _fadeAnimation = Tween<double>(begin: 0.0, end: 0.0).animate(
  //     CurvedAnimation(
  //       parent: _animationController,
  //       curve: Curves.easeInOut,
  //     ),
  //   );
  //
  //   _animationController.forward();
  //   Future.delayed(Duration(milliseconds: 2100), () {
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (context) => LoginScreen(), // Navigate to your main screen
  //       ),
  //     );
  //   });
  // }

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeInDown(
              duration:Duration(milliseconds: 2000) ,
              child: Container(
                height: 35.h,
                width: 100.w,
                decoration: BoxDecoration(
                  //color: Colors.grey,
                  image: DecorationImage(
                    image: AssetImage("assets/images/logo1-Photoroom.png-Photoroom.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            FadeInUp(
              duration: Duration(milliseconds: 2000),
              child: Container(
                  child: Center(child: Text("Welocome to Our Hotel",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w700,color: Colors.brown.shade800),))),
            )
          ],
        ),

      ),
    );
  }
}
