import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

import 'product_list_controller.dart';

class AddProductController extends GetxController {
  final productController = Get.find<ProductListController>();
  TextEditingController nameController = TextEditingController();
  TextEditingController unitPriceController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController categoryidController = TextEditingController();
  TextEditingController categoryNameController = TextEditingController();

  RxBool isLoading = false.obs;
  final box = GetStorage();

  Future<void> addProduct() async {
    try {
      isLoading.value = true;
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      final url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.otherendpoints.addproduct);

      Map body = {
        'name': nameController.text.toString(),
        'unit_price': unitPriceController.text.toString(),
        'unit_of_measure': typeController.text.toString(),
        'product_category_id': categoryidController.text.toString(),
      };

      var response = await http.post(
        url,
        body: body,
        headers: {
          'Authorization': 'Bearer ${box.read("userToken")}',
        },
      );
      print("body" + body.toString());
      final results = jsonDecode(response.body);
      print("code" + response.statusCode.toString());

      if (response.statusCode == 201) {
        productController.finallist.clear();
        productController.initialpage = 1;
        productController.fetchproduct();
        nameController.clear();
        unitPriceController.clear();
        typeController.clear();
        categoryidController.clear();
        categoryNameController.clear();

        Fluttertoast.showToast(
            msg: results["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        print("Client Added Successfully");
      } else {
        Fluttertoast.showToast(
            msg: results["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      print("Error during sign in: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
