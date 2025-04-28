import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoice_maker/dashboard.dart';
import 'package:invoice_maker/screens/sign_in_screen.dart';

import 'screens/splash_screen.dart';

void main() async {
  runApp(const MyApp());
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: FirebaseOptions(
  //     apiKey: "AIzaSyAK1E0gcO8oo0-fDTuW63TWYdKrkJLRGrk",
  //     authDomain: "invocie-maker.firebaseapp.com",
  //     projectId: "invocie-maker",
  //     storageBucket: "invocie-maker.appspot.com",
  //     messagingSenderId: "479279659549",
  //     appId: "1:479279659549:web:4a5dbea0a69da686e764f4",
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: DashBoard(),
    );
  }
}
