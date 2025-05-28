import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoice_maker/widgets/business_textbox.dart';

import 'invoicecontrollers/address_controller.dart';

class NewAddressScreen extends StatelessWidget {
  NewAddressScreen({super.key});

  final BusinessAddressController businessAddressController =
      Get.put(BusinessAddressController());

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Business Address",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey.shade300,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      BusinessTextbox(
                        hintText: "Business / Company Name",
                        controller:
                            businessAddressController.businessNameController,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      BusinessTextbox(
                        hintText: "Billing Address 1",
                        controller:
                            businessAddressController.address1Controller,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      BusinessTextbox(
                        hintText: "Billing Address 2",
                        controller:
                            businessAddressController.address2Controller,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      BusinessTextbox(
                        hintText: "phone No.",
                        controller:
                            businessAddressController.phoneNumberController,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      BusinessTextbox(
                        hintText: "Business Website",
                        controller: businessAddressController.websiteController,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(20),
                                    left: Radius.circular(20)),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              child: Center(
                                  child: Text(
                                "Cancel",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              )),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              box.write(
                                  "businessNameController",
                                  businessAddressController
                                      .businessNameController.text);
                              box.write(
                                  "address1Controller",
                                  businessAddressController
                                      .address1Controller.text);
                              box.write(
                                  "address2Controller",
                                  businessAddressController
                                      .address2Controller.text);
                              box.write(
                                  "phoneNumberController",
                                  businessAddressController
                                      .phoneNumberController.text);
                              box.write(
                                  "websiteController",
                                  businessAddressController
                                      .websiteController.text);
                              Get.back();
                            },
                            child: Container(
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(20),
                                    left: Radius.circular(20)),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              child: Center(
                                  child: Text(
                                "ADD",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
