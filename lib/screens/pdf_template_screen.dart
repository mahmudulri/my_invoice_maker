import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:invoice_maker/controllers/template_data_controller.dart';

import '../controllers/template_theme_controller.dart';

class PdfTemplateScreen extends StatelessWidget {
  PdfTemplateScreen({super.key});

  TemplateDataController templateDataController =
      Get.put(TemplateDataController());

  final TemplateController templateController = Get.put(TemplateController());

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Template")),
      body: Obx(() {
        if (templateController.isLoading.value) {
          return Center(child: SizedBox());
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.8,
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: templateDataController.elements.length,
              itemBuilder: (context, index) {
                final data = templateDataController.elements[index];

                return Obx(() {
                  final isSelected =
                      templateController.selectedIndex.value == index;

                  return GestureDetector(
                    onTap: () {
                      if (data["premium"] == "yes") {
                        Get.snackbar("Premium Template",
                            "Please upgrade to use this template!",
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.amber.shade700,
                            colorText: Colors.white,
                            icon: Icon(Icons.lock, color: Colors.white),
                            margin: EdgeInsets.all(12),
                            borderRadius: 12,
                            duration: Duration(seconds: 1));
                      } else {
                        templateController.setHeaderColor(data["color"], index);
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),

                        // ✅ Premium badge if template is premium
                        if (data["premium"] == "yes")
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "Premium",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                        // ✅ Selected checkmark
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 36,
                            shadows: [
                              Shadow(
                                blurRadius: 6,
                                color: Colors.black.withOpacity(0.5),
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                      ],
                    ),
                  );
                });
              }),
        );
      }),
    );
  }
}
