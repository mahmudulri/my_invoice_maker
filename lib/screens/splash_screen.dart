import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoice_maker/dashboard.dart';
import 'package:invoice_maker/services/notification_service.dart';

import '../draft/websocket_demo.dart';
import 'sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();

  checkColor() {
    if (box.read("tableheaderColor") == null) {
      box.write("tableheaderColor", "ff2c3e50");
    } else {
      print("has color before");
    }
  }

  // @override
  // void initState() {
  //   Future.delayed(Duration(seconds: 3), () => checkColor());
  //   super.initState();
  // }

  String text = "Stop service";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Splash Screen"),
            ElevatedButton(
              onPressed: () {
                print(box.read("tableheaderColor"));
              },
              child: Text("print color"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => DashBoard());
              },
              child: Text("dashboard"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => WebsocketDemo());
              },
              child: Text("Websocket"),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     FreeNotificationService().showNotification(
            //       title: "Confirmed ✅",
            //       body: "0700000000",
            //     );
            //   },
            //   child: Text("Local Notification"),
            // ),

            ElevatedButton(
              onPressed: () {
                FlutterBackgroundService().invoke('setAsForeground');
              },
              child: Text("Foreground Mode"),
            ),
            ElevatedButton(
              onPressed: () {
                FlutterBackgroundService().invoke('setAsBackground');
              },
              child: Text("Background Mode"),
            ),
            ElevatedButton(
              onPressed: () async {
                final service = FlutterBackgroundService();
                var isRunning = await service.isRunning();
                if (isRunning) {
                  service.invoke('stopService');
                } else {
                  service.startService();
                }
                if (!isRunning) {
                  text = "Stop Service";
                } else {
                  text = "Start Service";
                }
                setState(() {});
              },
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }
}
