import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sizer/sizer.dart';

import '../controller/registration_controller.dart';
import '../utils/app_colors.dart';
import '../widgets/text_field.dart';
import 'login_screen.dart';
import 'menu_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late RegistrationController registrationController;

  @override
  void initState() {
    super.initState();
    registrationController = Get.put(RegistrationController());
  }

  bool passwordObsecured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container(
              //   height: 30.h,
              //   width: 100.w,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: AssetImage("assets/images/logo1-Photoroom.png-Photoroom.png"),
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              Image.asset("assets/images/logo1-Photoroom.png-Photoroom.png",
                height: 25.h,width: 80.w,),
              Text(
                "Sign Up",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 26.sp,
                  color: Colors.brown.shade700,
                ),
              ),
              SizedBox(height: 2.5.h),
              Form(
                key: registrationController.formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: registrationController.usernameController,
                      hintText: "Username",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter UserName";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 2.5.h),
                    CustomTextField(
                      controller: registrationController.emailController,
                      hintText: "Email",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 2.5.h),
                    CustomTextField(
                      controller: registrationController.passController,
                      hintText: "Password",
                      obscureText: passwordObsecured,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            passwordObsecured = !passwordObsecured;
                          });
                        },
                        child: Icon(
                          passwordObsecured ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 1.5.h),
                    GestureDetector(
                      onTap: () {
                        // Add your Forgot Password functionality here
                      },
                      child: Padding(
                        padding:  EdgeInsets.only(left: 175.sp),
                        child: Text("Forgot Password ?",style: TextStyle(fontSize: 11.sp,fontWeight: FontWeight.w400),),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.h),
              InkWell(
                onTap: () async {
                  if (registrationController.formKey.currentState!.validate()) {
                    bool success = await registrationController.signUp(context);
                    if (success) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    }
                  }
                },
                child: Container(
                  height: 5.5.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: ColorsForApp.loginButtonColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 1.5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already Have An Account?",
                    style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(width: 1.5.w),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      registrationController.usernameController.clear();
                      registrationController.passController.clear();
                      registrationController.emailController.clear();
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: ColorsForApp.loginButtonColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h,),
              Container(
                child: Image.asset("assets/images/ab_new_logo-removebg-preview.png",height: 15.h,width: 30.w,),
              ),
              SizedBox(height: 3.h,),
              Text(
                "Branches: Pune | Satara | Kolhapur | Mumbai",
                style: TextStyle(fontSize: 11.sp),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6.w, top: 0.5.h),
                child: Row(
                  children: [
                    Logo(
                      Logos.whatsapp,
                      size: 3.h,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      "Contact Us: 8888732973 / 9699810037",
                      style: TextStyle(fontSize: 11.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
