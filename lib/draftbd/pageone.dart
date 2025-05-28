import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../invoicecontrollers/draftcontroller.dart';
import 'pagetwo.dart';

class PageOneBD extends StatelessWidget {
  PageOneBD({super.key});

  final Draftcontroller draftcontroller = Get.put(Draftcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              if (draftcontroller.nameText.value.isEmpty) {
                return Icon(
                  Icons.add,
                  size: 50,
                );
              } else {
                return Text(draftcontroller.nameText.value);
              }
            }),
            ElevatedButton(
              onPressed: () {
                Get.to(() => PagetwoBD());
              },
              child: Text("Next"),
            ),
            ElevatedButton(
              onPressed: () {
                print(draftcontroller.nameController.text);
              },
              child: Text("Print"),
            ),
          ],
        ),
      ),
    );
  }
}
