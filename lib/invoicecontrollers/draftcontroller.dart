import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Draftcontroller extends GetxController {
  TextEditingController nameController = TextEditingController();
  var nameText = ''.obs; // Observable to store current text

  @override
  void onInit() {
    super.onInit();
    // Listen for changes in the TextEditingController
    nameController.addListener(() {
      nameText.value = nameController.text;
    });
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}
