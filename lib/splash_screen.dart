import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoice_maker/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();

  checkToken() {
    if (box.read("userToken") == null) {
      Get.toNamed(signinscreen);
    } else {
      Get.toNamed(dashboard);
    }
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () => checkToken());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Get.toNamed(signinscreen);
          },
          child: Text(
            "Invoice Maker",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
