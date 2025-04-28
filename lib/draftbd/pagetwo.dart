import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/draftcontroller.dart';

class PagetwoBD extends StatelessWidget {
  PagetwoBD({super.key});

  final Draftcontroller draftcontroller = Get.put(Draftcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 250,
              color: Colors.grey,
              child: TextField(
                controller: draftcontroller.nameController,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                draftcontroller.nameController.text = "hasan bd bd";
              },
              child: Text("Add Hasan"),
            ),
            ElevatedButton(
              onPressed: () {
                draftcontroller.nameController.text = "Rajib bd bd";
              },
              child: Text("Add Rajib"),
            ),
            ElevatedButton(
              onPressed: () {
                draftcontroller.nameController.clear();
              },
              child: Text("Clear"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}
