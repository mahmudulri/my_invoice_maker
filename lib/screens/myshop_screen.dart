import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:invoice_maker/controllers/add_shop_controller.dart';
import 'package:invoice_maker/utils/api_endpoints.dart';
import 'package:invoice_maker/utils/colors.dart';

import '../controllers/myshoplist_controller.dart';
import '../invoicecontrollers/address_controller.dart';
import '../widgets/custom_text.dart';

class MyshopScreen extends StatefulWidget {
  MyshopScreen({super.key});

  @override
  State<MyshopScreen> createState() => _MyshopScreenState();
}

class _MyshopScreenState extends State<MyshopScreen> {
  final myshopcontroller = Get.find<MyshoplistController>();

  @override
  void initState() {
    super.initState();
    myshopcontroller.fetchshop();
  }

  final BusinessAddressController businessAddressController =
      Get.put(BusinessAddressController());

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF1F3FF),
      appBar: AppBar(
        backgroundColor: Color(0xffF1F3FF),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("My shops"),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      insetPadding: EdgeInsets.zero,

                      backgroundColor: Colors.transparent,
                      // insetPadding: EdgeInsets.all(0),
                      child: AddShopBox(),
                    );
                  },
                );
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primaryColor,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Obx(
          () => myshopcontroller.isLoading.value == false
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: myshopcontroller.allshoplist.value.shops!.length,
                    itemBuilder: (context, index) {
                      final data =
                          myshopcontroller.allshoplist.value.shops![index];
                      return GestureDetector(
                        onTap: () {
                          businessAddressController.businessNameController
                              .text = data.name.toString();
                          businessAddressController.address1Controller.text =
                              data.address.toString();
                          businessAddressController.phoneNumberController.text =
                              data.phoneNumber1.toString();
                          Get.back();
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(16), // smoother curve
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.1), // soft shadow
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: Offset(0, 4), // subtle vertical shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    data.logo.toString() == "null"
                                        ? CircleAvatar(
                                            radius: 32,
                                            backgroundColor:
                                                Colors.grey.shade200,
                                            child: CircleAvatar(
                                                radius: 30,
                                                backgroundColor: Colors.white),
                                          )
                                        : CircleAvatar(
                                            radius: 32,
                                            backgroundColor:
                                                Colors.grey.shade200,
                                            child: CircleAvatar(
                                              radius: 30,
                                              backgroundColor: Colors.white,
                                              backgroundImage: NetworkImage(
                                                ApiEndPoints.baseUrl +
                                                    data.logo.toString(),
                                              ),
                                            ),
                                          ),
                                    SizedBox(width: 20),

                                    /// ✅ Wrap Column with Expanded so text has constraints
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.name.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            data.address.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Colors.grey[700]),
                                          ),
                                          Text(
                                            data.phoneNumber1.toString(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  child: Container(
                                    height: 25,
                                    width: screenWidth,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.grey.shade300,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                bottomLeft: Radius.circular(15),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text("Edit"),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: double.maxFinite,
                                          width: 1,
                                          color: Colors.white,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.grey.shade300,
                                              ),
                                              color: Colors.white,
                                            ),
                                            child: Center(
                                              child: Text("View"),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: double.maxFinite,
                                          width: 1,
                                          color: Colors.white,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.grey.shade300,
                                              ),
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text("Delete"),
                                            ),
                                          ),
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
                    },
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}

class AddShopBox extends StatefulWidget {
  AddShopBox({super.key});

  @override
  State<AddShopBox> createState() => _AddShopBoxState();
}

class _AddShopBoxState extends State<AddShopBox> {
  final AddShopController addShopController = Get.put(AddShopController());
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.grey.shade400,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  KText(
                    text: "New Shop",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        Container(
                          height: 55,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey.shade400,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Shop name",
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 80,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey.shade400,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              maxLines: 4,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Shop Address",
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 60,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey.shade400,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Phone number 1",
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 60,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey.shade400,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Phone number 2",
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 60,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey.shade400,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Website",
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Obx(
                          () => addShopController.selectedImagePath.value == ""
                              ? Container(
                                  height: 130,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  child: GestureDetector(
                                    onTap: () async {
                                      await addShopController.uploadImage();
                                    },
                                    child: Center(
                                      child: Icon(
                                        FontAwesomeIcons.upload,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 130,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.grey,
                                    ),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: FileImage(
                                          addShopController.imageFile!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
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
