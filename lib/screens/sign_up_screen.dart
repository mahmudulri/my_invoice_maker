import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';

import 'package:intl/intl.dart';
import 'package:invoice_maker/dashboard.dart';
import 'package:invoice_maker/utils/colors.dart';
import 'package:invoice_maker/widgets/authtextfield.dart';
import 'package:invoice_maker/widgets/default_button.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  DateTime? selectedDate;
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Authtextfield(hinttext: "Phone number"),
              SizedBox(
                height: 10,
              ),
              Authtextfield(hinttext: "Password"),
              SizedBox(
                height: 10,
              ),
              Authtextfield(hinttext: "Confirm Password"),
              SizedBox(
                height: 10,
              ),
              Container(
                height: screenHeight * 0.065,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey.shade300,
                  ),
                  color: Color(0xffF9FAFB),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          selectedDate != null
                              ? DateFormat('dd MMM yyyy').format(selectedDate!)
                              : 'Date of Birth',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _selectDate,
                        child: Icon(
                          Icons.calendar_month,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                "This will use to recover your password",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              DefaultButton(
                buttonName: "Sign Up",
                mycolor: AppColors.primaryColor,
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have account ?",
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
                      Get.back();
                    },
                    child: Text(
                      "Sign In",
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
