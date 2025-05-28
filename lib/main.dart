import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoice_maker/dashboard.dart';
import 'package:invoice_maker/routes/routes.dart';

import 'screens/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  box = GetStorage();

  // await initializedService();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Makes status bar transparent
      statusBarIconBrightness:
          Brightness.light, // For dark icons (or use light)
      statusBarBrightness: Brightness.light, // For iOS
    ),
  );

  runApp(MyApp());
}

var box = GetStorage();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   useMaterial3: false,
      // ),
      initialRoute: splashscreen,
      getPages: myroutes,
    );
  }
}
