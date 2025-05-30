import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:invoice_maker/controllers/clinetlist_controller.dart';

import '../utils/api_endpoints.dart';
import 'product_list_controller.dart';

class DeleteClientController extends GetxController {
  final clientListController = Get.find<ClinetlistController>();
  final box = GetStorage();

  RxBool isLoading = false.obs;

  Future<void> deleteproduct(productID) async {
    try {
      isLoading.value = true;

      // var headers = {'Content-Type': 'application/json'};
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read("userToken")}'
      };
      var url = Uri.parse("${ApiEndPoints.baseUrl}products/delete/$productID}");

      http.Response response = await http.delete(
        url,
        headers: headers,
      );

      print("body${response.body}");
      print("statuscode${response.statusCode}");

      final results = jsonDecode(response.body);
      if (response.statusCode == 200) {
        clientListController.finallist.clear();
        clientListController.initialpage = 1;
        clientListController.fetchclients();
        if (results["status"] == true) {
          Fluttertoast.showToast(
            msg: results["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );

          isLoading.value = false;
        } else {
          Get.snackbar(
            "Opps !",
            results["message"],
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          isLoading.value = false;
        }
      } else {
        Get.snackbar(
          "Opps !",
          results["message"],
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
