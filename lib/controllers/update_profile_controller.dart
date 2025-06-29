import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

import '../utils/api_endpoints.dart';
import 'dashboard_controller.dart';

class UpdateProfileController extends GetxController {
  final box = GetStorage();

  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController1 = TextEditingController();
  TextEditingController phoneController2 = TextEditingController();

  TextEditingController addressController = TextEditingController();
  TextEditingController websiteController = TextEditingController();

  final DashboardController userinforController =
      Get.put(DashboardController());

  RxBool isLoading = false.obs;

  File? imageFile;
  var selectedImagePath = ''.obs;

  Future<void> noupdateProfile() async {
    try {
      isLoading.value = true;

      var headers = {'Content-Type': 'application/json'};

      var myurl = Uri.parse(
          "${ApiEndPoints.baseUrl}auth/update-profile?user_id=${box.read("userID")}");
      print(myurl.toString());

      var request = http.MultipartRequest('POST', myurl);

      request.fields.addAll({
        'full_name': nameController.text.toString(),
        "phone_number": phoneController1.text.toString(),
      });

      if (selectedImagePath.value.isNotEmpty) {
        // Only add image file if it is selected
        var file = await http.MultipartFile.fromPath(
          'thumbnail_image',
          selectedImagePath.value.toString(),
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(file);
      }
      print(selectedImagePath.toString());
      var response = await request.send();
      print(response.statusCode);

      if (response.statusCode == 200) {
        isLoading.value = false;
        final result = jsonDecode(response.toString());

        if (result["status"] == true) {
          Fluttertoast.showToast(
            msg: result["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          Fluttertoast.showToast(
            msg: result["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 13.0,
          );
        }
      } else {
        Get.snackbar(
          "Ops!",
          "Something error !",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isLoading.value = false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateProfile() async {
    try {
      isLoading.value = true;

      var headers = {'Content-Type': 'application/json'};
      var myurl = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.otherendpoints.updateprofile);

      var request = http.MultipartRequest('POST', myurl);

      request.fields.addAll({
        'full_name': nameController.text.toString(),
        "phone_number_1": phoneController1.text.toString(),
        "phone_number_2": phoneController2.text.toString(),
        "address": addressController.text.toString(),
        "website": websiteController.text.toString(),
      });

      if (selectedImagePath.value.isNotEmpty) {
        var file = await http.MultipartFile.fromPath(
          'thumbnail_image',
          selectedImagePath.value.toString(),
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(file);
      }

      var response = await request.send();

      // Convert the streamed response into a string
      var responseString = await response.stream.bytesToString();

      print(response.statusCode);

      if (response.statusCode == 200) {
        isLoading.value = false;
        // userinforController.fetchuserDatalist();

        // Parse the response string into a JSON object
        final result = jsonDecode(responseString);

        if (result["status"] == true) {
          Fluttertoast.showToast(
            msg: result["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.grey,
            fontSize: 16.0,
          );
        } else {
          Fluttertoast.showToast(
            msg: result["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 13.0,
          );
        }
      } else {
        Get.snackbar(
          "Ops!",
          "Something error !",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isLoading.value = false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
