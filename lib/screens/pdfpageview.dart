import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_maker/invoicecontrollers/template_data_controller.dart';
import '../invoicecontrollers/template_theme_controller.dart';

class Pdfpageview extends StatelessWidget {
  Pdfpageview({super.key});

  final TemplateDataController templateDataController =
      Get.put(TemplateDataController());

  final TemplateController templateController = Get.put(TemplateController());
  final TemplateListController templateListController =
      Get.put(TemplateListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffbdc3c7),
      appBar: AppBar(
        title: const Text("Select Template"),
        actions: [
          Obx(() {
            final templates = templateListController.templates;
            final selectedIndex = templateController.selectedIndex.value;
            if (selectedIndex < 0 || selectedIndex >= templates.length) {
              return const SizedBox.shrink();
            }
            final selectedTemplate = templates[selectedIndex];

            return TextButton(
              onPressed: () {
                if (selectedTemplate["ispremium"] == "yes") {
                  Get.snackbar(
                    "Premium Template",
                    "Upgrade to finalize this premium template!",
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.red.shade400,
                    colorText: Colors.white,
                    icon: const Icon(Icons.lock, color: Colors.white),
                    margin: const EdgeInsets.all(12),
                    borderRadius: 12,
                    duration: const Duration(milliseconds: 1800),
                  );
                } else {
                  // Save final selection
                  box.write("selectedTemplateName", selectedTemplate["name"]);
                  box.write("selectedTemplateIndex", selectedIndex);
                  // Get.back(); // or show a toast
                  Get.snackbar(
                    "Template Selected",
                    "You've successfully selected this template.",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green.shade600,
                    colorText: Colors.white,
                    margin: const EdgeInsets.all(12),
                    borderRadius: 12,
                    duration: const Duration(milliseconds: 1500),
                  );
                }
              },
              child: const Text(
                "Select",
                style: TextStyle(color: Colors.white),
              ),
            );
          })
        ],
      ),
      body: Obx(() {
        if (templateController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final templates = templateListController.templates;
        final selectedIndex = templateController.selectedIndex.value;

        return Column(
          children: [
            // Flex 5: Show selected template preview
            // Flex 5: Show selected template preview
            // Flex 5: Show selected template preview
            Expanded(
              flex: 5,
              child: templates.isEmpty || selectedIndex < 0
                  ? const Center(child: Text("No template selected"))
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  templates[selectedIndex]["imglink"]
                                      .toString(),
                                ),
                                fit: BoxFit.fill,
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.black12,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                          ),
                          if (templates[selectedIndex]["ispremium"] == "yes")
                            Positioned(
                              bottom: 40,
                              left: 20,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                child: Image.asset(
                                  "assets/icons/vip.png", // your asset image path
                                  height: 50,
                                  width: 50,
                                  // optional tint
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
            ),

            // Flex 2: Template List (horizontal)
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: templates.length,
                  itemBuilder: (context, index) {
                    final data = templates[index];
                    final isSelected = selectedIndex == index;

                    return GestureDetector(
                      onTap: () {
                        // Preview any template
                        templateController.selectedIndex.value = index;
                      },
                      child: Container(
                        width: 130,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(data["imglink"].toString()),
                            fit: BoxFit.fill,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Stack(
                          children: [
                            if (data["premium"] == "yes")
                              Positioned(
                                top: 6,
                                right: 6,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Text(
                                    "Premium",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            if (isSelected)
                              const Positioned(
                                bottom: 6,
                                right: 6,
                                child: Icon(Icons.check_circle,
                                    color: Colors.green),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
