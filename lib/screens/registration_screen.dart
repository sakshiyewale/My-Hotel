import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:my_hotel/controller/login_controller.dart'; // Assuming LoginController is defined in this file
import 'package:my_hotel/controller/registration_controller.dart';
import 'package:my_hotel/screens/login_screen.dart';
import 'package:my_hotel/utils/app_colors.dart';
import 'package:sizer/sizer.dart';
import '../widgets/text_field.dart';
import 'menu_screen.dart';
import 'package:http/http.dart'as http;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late RegistrationController registrationController; // Define loginController as a late variable

  @override
  void initState() {
    super.initState();
    // Initialize LoginController here
    registrationController = Get.put(RegistrationController());
  }
  bool passwordObsecured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 15.sp,vertical:15.sp),
          child: Column(
            children: [
              SafeArea(
                child: Container(
                  height: 30.h,
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
              SizedBox(
                height: 1.h,
              ),
              Text("Sign Up",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 26.sp,color: Colors.brown.shade700),),
              SizedBox(
                height: 2.5.h,
              ),
              Form(
                key: registrationController.formKey ,
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
                    SizedBox(height: 2.5.h,),
                    CustomTextField(
                      controller: registrationController.emailController,
                      hintText: "email",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter email";
                        }
                        return null;
                      },

                    ),
                    SizedBox(height: 2.5.h,),
                    CustomTextField(
                      controller: registrationController.passController,
                      hintText: "Password",
                      obscureText: passwordObsecured,
                      suffixIcon: GestureDetector(
                          onTap: (){
                            setState(() {
                              passwordObsecured =!passwordObsecured;
                            });
                          },
                          child:passwordObsecured? Icon(Icons.visibility_off):Icon(Icons.visibility)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 1.5.h,),
                    Padding(
                      padding:  EdgeInsets.only(left: 140.sp),
                      child: Text("Forgot Password ?",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w400),),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.h,),
              InkWell(
                onTap: (){
                  if(registrationController.formKey .currentState!.validate())
                  {
                    registrationController.SignUp();
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>MenuScreen()));

                  }
                },
                child: Container(
                  height: 6.2.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: ColorsForApp.loginButtonColor,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(child: Text("Sign Up",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500,color: Colors.white),)),
                ),
              ),
              SizedBox(height: 3.5.w,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already Have An Account?",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400),),
                  SizedBox(width: 2.5.w,),
                  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },
                      child: Text("Sign In",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w700,color: ColorsForApp.loginButtonColor),))
                ],
              ),
              SizedBox(height: 3.h,),
              Text("Branches: Pune | Satara |Kolhapur | Mumbai",style: TextStyle(fontSize: 11.sp),),
              // SizedBox(height: 0.3.h,),
              Padding(
                padding:  EdgeInsets.only(left: 6.w,top: 0.5.h),
                child: Row(
                  children: [
                    Logo(
                      Logos.whatsapp,
                      size: 3.h,
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Text("Contact Us :8888732973 / 9699810037",style: TextStyle(fontSize: 11.sp),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
