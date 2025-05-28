import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../utils/api_endpoints.dart';

class SignInController extends GetxController {
  final box = GetStorage();

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool loginsuccess = false.obs;

  Future<void> signIn() async {
    try {
      isLoading.value = true;
      loginsuccess.value = true; // Reset to false before starting login
      print(loginsuccess.value);
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      var url = Uri.parse("${ApiEndPoints.baseUrl}auth/sign-in");

      print("API URL: $url");

      Map body = {
        'phone_number': phoneNumberController.text,
        'password': passwordController.text,
      };

      // Map body = {
      //   'username': "0796321321",
      //   'password': "12345678",
      // };

      // print("Request Body: $body");

      http.Response response = await http.post(
        url,
        body: jsonEncode(body),
        headers: headers,
      );

      final results = jsonDecode(response.body);
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        box.write("userToken", results["token"]);
        print(results["token"]);

        if (results["status"] == true) {
          loginsuccess.value = false;

          print(loginsuccess.value);

          Fluttertoast.showToast(
              msg: results["message"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);

          // Fetch country data only if login is successful
        } else {
          Get.snackbar(
            "Oops!",
            results["message"],
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Oops!",
          results["message"],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("Error during sign in: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
