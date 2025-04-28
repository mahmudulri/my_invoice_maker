import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dashboard.dart';
import 'screens/home_screen.dart';

class WelcomScreen extends StatelessWidget {
  const WelcomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Get.to(() => DashBoard());
          },
          child: Text("Welcome Screen"),
        ),
      ),
    );
  }
}
