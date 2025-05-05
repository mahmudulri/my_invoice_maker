import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';

import 'package:invoice_maker/dashboard.dart';
import 'package:invoice_maker/utils/colors.dart';
import 'package:invoice_maker/widgets/authtextfield.dart';
import 'package:invoice_maker/widgets/default_button.dart';

import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    // checkColor();

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 180,
              ),
              Text(
                "Smart Invoice Generator",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Authtextfield(hinttext: "Phone number"),
              SizedBox(
                height: 10,
              ),
              Authtextfield(hinttext: "Password"),
              SizedBox(
                height: 10,
              ),
              DefaultButton(
                buttonName: "Sign in",
                mycolor: AppColors.primaryColor,
                onpressed: () {
                  Get.to(() => DashBoard());
                },
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Forgot pasasword ?",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: screenHeight * 0.016,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Recover password",
                    style: TextStyle(
                      color: Color(0xff1890FF),
                      fontSize: screenHeight * 0.017,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Have not register yet ?",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: screenHeight * 0.022,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color(0xff1890FF),
                        fontSize: screenHeight * 0.022,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
