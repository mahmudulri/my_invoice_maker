import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ========== Business Address Controller ==========
class BusinessAddressController extends GetxController {
  TextEditingController businessNameController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController websiteController = TextEditingController();

  var businessNameText = ''.obs;
  var address1Text = ''.obs;
  var address2Text = ''.obs;
  var phoneNumberText = ''.obs;
  var websiteText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    businessNameController.addListener(_updateValues);
    address1Controller.addListener(_updateValues);
    address2Controller.addListener(_updateValues);
    phoneNumberController.addListener(_updateValues);
    websiteController.addListener(_updateValues);
  }

  void _updateValues() {
    businessNameText.value = businessNameController.text;
    address1Text.value = address1Controller.text;
    address2Text.value = address2Controller.text;
    phoneNumberText.value = phoneNumberController.text;
    websiteText.value = websiteController.text;
  }

  @override
  void onClose() {
    businessNameController.dispose();
    address1Controller.dispose();
    address2Controller.dispose();
    phoneNumberController.dispose();
    websiteController.dispose();
    super.onClose();
  }
}

// ========== Client Address Controller ==========
class ClientAddressController extends GetxController {
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
    nameController.addListener(_updateValues);
    address1Controller.addListener(_updateValues);
    address2Controller.addListener(_updateValues);
    phoneNumberController.addListener(_updateValues);
    websiteController.addListener(_updateValues);
  }

  void _updateValues() {
    nameText.value = nameController.text;
    address1Text.value = address1Controller.text;
    address2Text.value = address2Controller.text;
    phoneNumberText.value = phoneNumberController.text;
    websiteText.value = websiteController.text;
  }

  @override
  void onClose() {
    nameController.dispose();
    address1Controller.dispose();
    address2Controller.dispose();
    phoneNumberController.dispose();
    websiteController.dispose();
    super.onClose();
  }
}
