import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoice_maker/utils/colors.dart';
import 'package:invoice_maker/widgets/authtextfield.dart';
import 'package:invoice_maker/widgets/default_button.dart';
import 'package:lottie/lottie.dart';
import '../controllers/auth_controller.dart';
import '../controllers/sign_in_controller.dart';
import '../routes/routes.dart';
import 'sign_up_screen.dart';
import 'package:local_auth/local_auth.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final box = GetStorage();

  final signInController = Get.find<SignInController>();

  final AuthController authController = Get.put(AuthController());

  Future<bool> showExitPopup() async {
    // if (mypagecontroller.currentPage.value.runtimeType != Homepages) {
    //   mypagecontroller.goBackToLastMainPage();
    //   return false; // Prevent exit
    // }
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you want to exit an App?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              ElevatedButton(
                onPressed: () {
                  exit(0);
                },
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    // checkColor();

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        body: Container(
          height: screenHeight,
          width: screenWidth,
          child: Stack(
            children: [
              Positioned(
                top: -150,
                left: 50,
                child: CircleAvatar(
                  radius: 250,
                  backgroundColor: Color(0xffE8F2FC),
                ),
              ),
              Positioned(
                top: 150,
                left: 250,
                child: CircleAvatar(
                  radius: 200,
                  backgroundColor: Color(0xffE8F2FC),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: Container(
                          height: 200,
                          width: 200,
                          // color: Colors.red,
                          child: Lottie.asset('assets/lotties/maninvoice.json'),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Welcome to",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Mega Invoice",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Maker",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Authtextfield(
                        hinttext: "Phone number",
                        controller: signInController.phoneNumberController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Authtextfield(
                        hinttext: "Password",
                        controller: signInController.passwordController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => DefaultButton(
                          buttonName: signInController.isLoading.value == false
                              ? "Sign in"
                              : "Please wait",
                          mycolor: AppColors.primaryColor,
                          onpressed: () async {
                            if (signInController
                                    .phoneNumberController.text.isEmpty ||
                                signInController
                                    .passwordController.text.isEmpty) {
                              Get.snackbar("Oops!", "Fill the text fields");
                            } else {
                              print("Attempting login...");
                              await signInController.signIn();

                              if (signInController.loginsuccess.value ==
                                  false) {
                                Get.toNamed(dashboard);
                              } else {
                                print("Navigation conditions not met.");
                              }
                            }
                          },
                        ),
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
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          signInController.phoneNumberController.text =
                              "01721856206";
                          signInController.passwordController.text = "000000";
                          await signInController.signIn();
                          if (signInController.loginsuccess.value = true) {
                            Get.toNamed(dashboard);
                          }
                        },
                        child: Text("Demo User"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
