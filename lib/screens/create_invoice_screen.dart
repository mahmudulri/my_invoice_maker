import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_maker/utils/colors.dart';

import '../controllers/address_controller.dart';
import '../controllers/billto_controller.dart';
import '../controllers/item_list_controller.dart';
import '../new_address.dart';
import '../pdftemplates/pdftemplate1.dart';
import 'new_client.dart';
import 'new_items.dart';
import 'pdtview_screen.dart';

class CreateInvoiceScreen extends StatefulWidget {
  const CreateInvoiceScreen({super.key});

  @override
  State<CreateInvoiceScreen> createState() => _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState extends State<CreateInvoiceScreen> {
  final BusinessAddressController businessAddressController =
      Get.put(BusinessAddressController(), permanent: true);
  final BilltoController billtoController = Get.put(BilltoController());
  final ItemListController itemListController = Get.put(
    ItemListController(),
    permanent: true,
  );

  final PdfTemplate1 pdfTemplate1 = PdfTemplate1();
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffecf0f1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffecf0f1),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Create New Invoices",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Container(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    //...........................................Address & info area................................//

                    Container(
                      height: 170,
                      width: screenWidth,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0),
                        boxShadow: [
                          // strong top shadow
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.15), // stronger and darker
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset:
                                Offset(0, -1), // negative Y moves shadow upward
                          ),

                          // subtle bottom shadow (optional)
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        // color: Colors.red,
                                        child: Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Center(
                                            child: Image.asset(
                                              "assets/icons/shop.png",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      color: Colors.grey.shade300,
                                      height: double.infinity,
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right: 10,
                                            top: 5,
                                            bottom: 5,
                                            left: 15),
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(
                                              () => NewAddressScreen(),
                                            );
                                          },
                                          child: businessAddressController
                                                  .businessNameController
                                                  .text
                                                  .isNotEmpty
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      businessAddressController
                                                          .businessNameController
                                                          .text,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          businessAddressController
                                                              .address1Controller
                                                              .text,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        Text(
                                                          ", ${businessAddressController.address2Controller.text}",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      businessAddressController
                                                          .phoneNumberController
                                                          .text,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    if (businessAddressController
                                                        .websiteController
                                                        .text
                                                        .isNotEmpty)
                                                      Text(
                                                        businessAddressController
                                                            .websiteController
                                                            .text,
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                  ],
                                                )
                                              : Center(
                                                  child: Text(
                                                      "Click to Add Your Business info."),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.grey.shade300,
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        // color: Colors.red,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Center(
                                            child: Image.asset(
                                              "assets/icons/client.png",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      color: Colors.grey.shade300,
                                      height: double.infinity,
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right: 10,
                                            top: 5,
                                            bottom: 5,
                                            left: 15),
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(
                                              () => NewClientScreen(),
                                            );
                                          },
                                          child: Obx(() {
                                            if (billtoController
                                                .nameText.value.isNotEmpty) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    billtoController
                                                        .nameController.text,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        billtoController
                                                            .address1Controller
                                                            .text,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      Text(
                                                        billtoController
                                                            .address2Controller
                                                            .text,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    billtoController
                                                        .phoneNumberController
                                                        .text,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  if (billtoController
                                                      .websiteController
                                                      .text
                                                      .isNotEmpty)
                                                    Text(
                                                      billtoController
                                                          .websiteController
                                                          .text,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                ],
                                              );
                                            } else {
                                              return Center(
                                                child: Text(
                                                  "Add Client Info.",
                                                ),
                                              );
                                            }
                                          }),
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
                    SizedBox(
                      height: 5,
                    ),
                    //...........................................Table Content................................//
                    Text(
                      "Items",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Obx(
                      () => itemListController.itemlist.isNotEmpty
                          ? Container(
                              decoration: BoxDecoration(
                                color: AppColors.borderColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              width: screenWidth,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 3,
                                    );
                                  },
                                  shrinkWrap: true,
                                  itemCount: itemListController.itemlist.length,
                                  itemBuilder: (context, index) {
                                    final data =
                                        itemListController.itemlist[index];
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          // strong top shadow
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                                0.15), // stronger and darker
                                            spreadRadius: 0,
                                            blurRadius: 2,
                                            offset: Offset(0,
                                                -1), // negative Y moves shadow upward
                                          ),

                                          // subtle bottom shadow (optional)
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.05),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      width: screenWidth,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  data["name"],
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        data["quantity"],
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        data["unitofmeasure"],
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      Text(
                                                        " × ",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      Text(
                                                        data["unitprice"],
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Visibility(
                                              visible: data["discount"] != "",
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    // ignore: prefer_interpolation_to_compose_strings
                                                    "Discount " +
                                                        data["discount"] +
                                                        data["discounttype"],
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    "-" + data["discount"],
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Visibility(
                                              visible: data["vat"] != "",
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    // ignore: prefer_interpolation_to_compose_strings
                                                    "Tax " + data["vat"] + " %",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    "+" + data["vat"],
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  // ignore: prefer_interpolation_to_compose_strings
                                                  data["total"],
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          : Center(
                              child: Text(
                              "No Items",
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            )),
                    ),
                    //.............................Final ...................................//
                    SizedBox(
                      height: 10,
                    ),

                    Text(
                      "Total",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      // height: 200,
                      width: screenWidth,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0),
                        boxShadow: [
                          // strong top shadow
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.15), // stronger and darker
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset:
                                Offset(0, -1), // negative Y moves shadow upward
                          ),

                          // subtle bottom shadow (optional)
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sub Total : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                                Obx(
                                  () => itemListController
                                              .subtotalloading.value ==
                                          false
                                      ? Text(
                                          itemListController.totalPrice.value
                                              .toStringAsFixed(2),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 14,
                                          ),
                                        )
                                      : Text("calculating"),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Discount (${itemListController.discount}%) : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  itemListController.discountedPrice.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Tax (${itemListController.tax}%%) : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  itemListController.taxmount.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                  ),
                                ),
                                Obx(
                                  () => itemListController.isloading.value ==
                                          false
                                      ? Text(
                                          itemListController.subTotalPrice.value
                                              .toStringAsFixed(2),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 14,
                                          ),
                                        )
                                      : Text("calculating"),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 60,
                width: screenWidth,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () async {
                          final data = await pdfTemplate1.generatePDF();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PdfPreviewScreen(pdfBytes: data),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(20)),
                            border: Border.all(
                              width: 1,
                              color: Colors.grey.shade300,
                            ),
                          ),
                          child: Center(
                              child: Text(
                            "Preview",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => NewItemsScreen());
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(20)),
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
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
