import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:invoice_maker/controllers/template_data_controller.dart';

import '../controllers/template_theme_controller.dart';

class PdfTemplateScreen extends StatelessWidget {
  PdfTemplateScreen({super.key});

  // TemplateDataController templateDataController =
  //     Get.put(TemplateDataController());

  final TemplateController templateController = Get.put(TemplateController());
  final TemplateListController templateListController =
      Get.put(TemplateListController());

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffbdc3c7),
      appBar: AppBar(title: Text("Select Template")),
      body: Obx(() {
        if (templateController.isLoading.value) {
          return Center(child: SizedBox());
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.7,
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: templateListController.templates.length,
              itemBuilder: (context, index) {
                final data = templateListController.templates[index];

                return Obx(() {
                  final isSelected =
                      templateController.selectedIndex.value == index;

                  return GestureDetector(
                    onTap: () {
                      if (data["ispremium"] == "yes") {
                        Get.snackbar(
                          "Premium Template",
                          "Please upgrade to use this template!",
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.amber.shade700,
                          colorText: Colors.white,
                          icon: Icon(Icons.lock, color: Colors.white),
                          margin: EdgeInsets.all(12),
                          borderRadius: 12,
                          duration: Duration(milliseconds: 1500),
                        );
                      } else {
                        // ✅ Save selected template name and index
                        box.write("selectedTemplateName", data["name"]);
                        box.write("selectedTemplateIndex", index);

                        // ✅ Update UI
                        templateController.selectedIndex.value = index;
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(data["imglink"].toString()),
                              fit: BoxFit.fill,
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
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
