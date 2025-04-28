import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final box = GetStorage();

class TemplateController extends GetxController {
  final Rx<Color> tableHeaderColor =
      Color(int.parse(box.read("tableheaderColor") ?? "0xff2c3e50")).obs;

  final RxInt selectedIndex = (-1).obs;
  final RxBool isLoading = true.obs; // NEW

  @override
  void onInit() {
    super.onInit();

    // Simulate a short delay (optional)
    Future.delayed(Duration(milliseconds: 200), () {
      int? savedIndex = box.read("selectedTemplateIndex");
      if (savedIndex != null) {
        selectedIndex.value = savedIndex;
      }

      isLoading.value = false; // Done loading
    });
  }

  void setHeaderColor(String colorStr, int index) {
    colorStr = colorStr.replaceAll("0xff", "").replaceAll("0x", "");
    final fullColorStr = "0xff$colorStr";
    final color = Color(int.parse(fullColorStr));

    tableHeaderColor.value = color;
    box.write("tableheaderColor", fullColorStr);

    selectedIndex.value = index;
    box.write("selectedTemplateIndex", index);
  }
}
