import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

import 'clinetlist_controller.dart';

class AddShopController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  RxBool isLoading = false.obs;
  final box = GetStorage();

  var selectedImagePath = ''.obs;

  File? imageFile;

  Future<void> uploadImage() async {
    final pickedImageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImageFile != null) {
      selectedImagePath.value = pickedImageFile.path;
      imageFile = File(pickedImageFile.path);
      print(" before image tag   " + imageFile.toString());
    } else {
      print("No image selected");
    }
  }

  Future<void> addshop() async {
    try {
      isLoading.value = true;
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      final url =
          Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.otherendpoints.addshop);

      Map body = {
        'name': nameController.text,
        'phone_number': phoneController.text,
        'address': addressController.text,
      };

      var response = await http.post(
        url,
        body: body,
        headers: {
          'Authorization': 'Bearer ${box.read("userToken")}',
        },
      );
      final results = jsonDecode(response.body);

      if (response.statusCode == 200) {
        nameController.clear();
        phoneController.clear();
        addressController.clear();
        // clientListController.finallist.clear();
        // clientListController.initialpage = 1;
        // clientListController.fetchclients();
        Fluttertoast.showToast(
            msg: "Client Added Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        print("Client Added Successfully");
      } else {
        print("object");
      }
    } catch (e) {
      print("Error during sign in: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
