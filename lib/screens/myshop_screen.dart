import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_maker/utils/api_endpoints.dart';
import 'package:invoice_maker/utils/colors.dart';

import '../controllers/myshoplist_controller.dart';
import '../invoicecontrollers/address_controller.dart';

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
                    return AlertDialog(
                      backgroundColor: Colors.transparent,
                      contentPadding: EdgeInsets.all(0.0),
                      content: AddShopBox(),
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
                        onTap: () {},
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

class AddShopBox extends StatelessWidget {
  const AddShopBox({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
        height: 450,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ));
  }
}
