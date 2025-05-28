import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BilltoController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController websiteController = TextEditingController();

  var nameText = ''.obs;
  var address1Text = ''.obs;
  var address2Text = ''.obs;
  var phoneNumberText = ''.obs;
  var websiteText = ''.obs;

  @override
  void onInit() {
    super.onInit();

    nameController.addListener(() {
      nameText.value = nameController.text;
      address1Text.value = address1Controller.text;
      address2Text.value = address2Controller.text;
      phoneNumberText.value = phoneNumberController.text;
      websiteText.value = websiteController.text;
    });
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}
