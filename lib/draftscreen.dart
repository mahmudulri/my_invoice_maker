import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoice_maker/main.dart';

import 'controllers/mycontroller.dart';
import 'order_notifier.dart/order_notifier.dart';

class Draftscreen extends StatefulWidget {
  const Draftscreen({super.key});

  @override
  State<Draftscreen> createState() => _DraftscreenState();
}

class _DraftscreenState extends State<Draftscreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(box.read("orderID"));

    return Scaffold(
      appBar: AppBar(title: const Text(" Order Status")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
            ),
            ElevatedButton(
              onPressed: () {
                box.write("orderID", controller.text);
              },
              child: const Text("Add"),
            ),
            ElevatedButton(
              onPressed: () {
                print(box.read("orderID"));
              },
              child: const Text("Print"),
            ),
          ],
        ),
      ),
    );
  }
}
