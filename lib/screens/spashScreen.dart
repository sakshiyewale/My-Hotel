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
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800), // Adjust duration as needed
    );


    _fadeAnimation = Tween<double>(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
    Future.delayed(Duration(milliseconds: 1900), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginScreen(), // Navigate to your main screen
        ),
      );
    });
  }

  @override
  void dispose() {
    // Dispose animation controller
    _animationController.dispose();
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
              duration:Duration(milliseconds: 1000) ,
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
            SizedBox(height: 1.h,),
            FadeInUp(
              duration: Duration(milliseconds: 1900),
              child: Container(
                  child: Center(child: Text("Welocome to Our Hotel",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w700,color: Colors.brown.shade800),))),
            )
          ],
        ),

      ),
    );
  }
}
