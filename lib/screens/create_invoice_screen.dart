import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:invoice_maker/routes/routes.dart';
import 'package:invoice_maker/utils/colors.dart';

import '../invoicecontrollers/address_controller.dart';
import '../invoicecontrollers/billto_controller.dart';
import '../invoicecontrollers/invoice_data_controller.dart';
import '../invoicecontrollers/item_list_controller.dart';
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

  final InvoiceDataController invoiceDataController = Get.put(
    InvoiceDataController(),
    permanent: true,
  );

  List statusList = [
    "Unpaid",
    "Paid",
    "Due",
  ];

  TextEditingController vatController = TextEditingController();
  TextEditingController paidAmount = TextEditingController();

  TextEditingController discountController = TextEditingController();
  TextEditingController taxController = TextEditingController();
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
                                            Get.toNamed(myshopscreen);
                                          },
                                          child: Obx(() {
                                            if (businessAddressController
                                                .businessNameText
                                                .value
                                                .isNotEmpty) {
                                              return Column(
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
                                                            FontWeight.w500),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        businessAddressController
                                                            .address1Controller
                                                            .text,
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        ", ${businessAddressController.address2Controller.text}",
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    businessAddressController
                                                        .phoneNumberController
                                                        .text,
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                  if (businessAddressController
                                                      .websiteText
                                                      .value
                                                      .isNotEmpty)
                                                    Text(
                                                      businessAddressController
                                                          .websiteController
                                                          .text,
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                ],
                                              );
                                            } else {
                                              return Center(
                                                  child: Text(
                                                      "Add Your shop info."));
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
                                            Get.toNamed(clientscreen);
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
                                padding: EdgeInsets.all(5.0),
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
                                    return GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text('Remove Item'),
                                            content: Text(
                                                'Are you sure you want to remove this item?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  itemListController
                                                      .deleteItem(index);
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Remove'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                              color: Colors.black
                                                  .withOpacity(0.05),
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
                                                      "Tax " +
                                                          data["vat"] +
                                                          " %",
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     color: invoiceDataController.invoiceStatus
                        //                 .toString() ==
                        //             "Paid"
                        //         ? Colors.green
                        //         : Colors.red,
                        //     borderRadius: BorderRadius.circular(6),
                        //   ),
                        //   child: Padding(
                        //     padding: const EdgeInsets.symmetric(
                        //         horizontal: 8, vertical: 4),
                        //     child: Text(
                        //       invoiceDataController.invoiceStatus.toString(),
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    //.............................Status ...................................//
                    SizedBox(
                      height: 40,
                      width: screenWidth,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.transparent,
                                      contentPadding: EdgeInsets.all(0.0),
                                      content: Container(
                                        height: 160,
                                        width: screenWidth,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Apply your Discount in %"),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Container(
                                                height: 50,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                  ),
                                                  child: TextField(
                                                    onChanged: (value) {
                                                      // Check if the input value is empty; if so, set discount to 0.0
                                                      itemListController
                                                          .discount = value
                                                              .isEmpty
                                                          ? 0.00
                                                          : double.parse(value);
                                                      itemListController
                                                          .calculateTotalPrice();
                                                    },
                                                    controller:
                                                        discountController,
                                                    textAlign: TextAlign.center,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Cancel",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      // if (discountController
                                                      //     .text.isNotEmpty) {
                                                      //   itemListController
                                                      //           .discount =
                                                      //       double.parse(
                                                      //           discountController
                                                      //               .text);

                                                      //   print(itemListController
                                                      //       .discount
                                                      //       .toString());
                                                      //   itemListController
                                                      //       .getTotalPrice();
                                                      // } else {
                                                      //   print("Add Data");
                                                      // }
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "OK",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                child: Center(
                                  child: Text("Discount"),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.transparent,
                                      contentPadding: EdgeInsets.all(0.0),
                                      content: Container(
                                        height: 160,
                                        width: screenWidth,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Apply your vat in %"),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Container(
                                                height: 50,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                  ),
                                                  child: TextField(
                                                    onChanged: (value) {
                                                      itemListController
                                                          .tax = value
                                                              .isEmpty
                                                          ? 0.00
                                                          : double.parse(value);
                                                      itemListController
                                                          .calculateTotalPrice();
                                                    },
                                                    controller: taxController,
                                                    textAlign: TextAlign.center,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Cancel",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Apply",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                child: Center(
                                  child: Text("Tax"),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.transparent,
                                      contentPadding: EdgeInsets.all(0.0),
                                      content: Container(
                                        height: 160,
                                        width: screenWidth,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Enter your shipping cost"),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Container(
                                                height: 50,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                  ),
                                                  child: TextField(
                                                    onChanged: (value) {
                                                      itemListController
                                                          .shippingcost = value
                                                              .isEmpty
                                                          ? 0.00
                                                          : double.parse(value);
                                                      itemListController
                                                          .calculateTotalPrice();
                                                    },
                                                    controller: taxController,
                                                    textAlign: TextAlign.center,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Cancel",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Apply",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                child: Center(
                                  child: Text("Shipping cost"),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.transparent,
                                      contentPadding: EdgeInsets.all(0.0),
                                      content: Container(
                                        height: 270,
                                        width: screenWidth,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      itemListController
                                                          .dueamount
                                                          .value = 0.0;
                                                      itemListController
                                                          .paidAmount
                                                          .value = 0.0;
                                                      invoiceDataController
                                                          .dueDate.value = "";
                                                      setState(() {
                                                        invoiceDataController
                                                                .invoiceStatus =
                                                            "Paid";

                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 50,
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                        color: Colors.green,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Full Paid",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        invoiceDataController
                                                                .invoiceStatus =
                                                            "Unpaid";
                                                        itemListController
                                                                .dueamount
                                                                .value =
                                                            double.parse(
                                                                itemListController
                                                                    .totalPrice
                                                                    .toString());

                                                        itemListController
                                                            .paidAmount
                                                            .value = 0;
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 45,
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                        color: Colors.red,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Full Unpaid",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text("Paid Amount : "),
                                                  Container(
                                                    height: 50,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      border: Border.all(
                                                        width: 1,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                      ),
                                                      child: Center(
                                                        child: TextField(
                                                          controller:
                                                              paidAmount,
                                                          textAlign:
                                                              TextAlign.center,
                                                          onChanged: (value) {
                                                            double paid =
                                                                double.tryParse(
                                                                        value) ??
                                                                    0.0;
                                                            itemListController
                                                                .updatePaidAmount(
                                                                    paid);
                                                          },
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText: "Amount",
                                                            hintStyle:
                                                                TextStyle(
                                                              fontSize: 15,
                                                            ),
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text("Payable Date: "),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      // Open the Date Picker
                                                      DateTime? pickedDate =
                                                          await showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate:
                                                            DateTime(2000),
                                                        lastDate:
                                                            DateTime(2101),
                                                      );

                                                      if (pickedDate != null) {
                                                        // Format the picked date to a string and update the controller
                                                        String formattedDate =
                                                            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                                                        setState(() {
                                                          invoiceDataController
                                                                  .dueDate
                                                                  .value =
                                                              formattedDate;
                                                        });
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 45,
                                                      width: 150,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: Colors.grey),
                                                      ),
                                                      child: Center(
                                                        child: Obx(
                                                          () => Text(
                                                            invoiceDataController
                                                                        .dueDate
                                                                        .toString() ==
                                                                    ""
                                                                ? "Select"
                                                                : invoiceDataController
                                                                    .dueDate
                                                                    .toString(),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      paidAmount.clear();
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      height: 45,
                                                      width: 130,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        border: Border.all(
                                                          width: 1,
                                                          color: Colors.grey,
                                                        ),
                                                        color: Colors.grey,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Cancel",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (invoiceDataController
                                                          .dueDate
                                                          .value
                                                          .isNotEmpty) {
                                                        setState(() {
                                                          invoiceDataController
                                                                  .invoiceStatus =
                                                              "Due";
                                                        });
                                                        paidAmount.clear();
                                                        Navigator.pop(context);
                                                      } else {
                                                        Fluttertoast.showToast(
                                                          msg:
                                                              "Select Payable Date",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity:
                                                              ToastGravity.TOP,
                                                          timeInSecForIosWeb: 2,
                                                          backgroundColor:
                                                              Colors.black87,
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 16.0,
                                                        );
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 45,
                                                      width: 130,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        border: Border.all(
                                                          width: 1,
                                                          color: Colors.grey,
                                                        ),
                                                        color: Colors.grey,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Ok",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  color: invoiceDataController.invoiceStatus
                                                  .toString() ==
                                              "Unpaid" ||
                                          invoiceDataController.invoiceStatus
                                                  .toString() ==
                                              "Due"
                                      ? Colors.red
                                      : Colors.green,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    invoiceDataController.invoiceStatus
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Shipping cost : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  itemListController.shippingcost.toString(),
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
                            Visibility(
                              visible:
                                  // ignore: unrelated_type_equality_checks
                                  itemListController.paidAmount != 0.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Paid Amount : ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    itemListController.paidAmount.value
                                        .toStringAsFixed(2),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              // ignore: unrelated_type_equality_checks
                              visible: itemListController.dueamount != 0.0 ||
                                  invoiceDataController.invoiceStatus
                                          .toString() ==
                                      "Unpaid",

                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Due Balance : ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    invoiceDataController.dueDate.toString(),
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                  Spacer(),
                                  Obx(
                                    () => Text(
                                      itemListController.dueamount.value
                                          .toStringAsFixed(2),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                ],
                              ),
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
                        // Get.to(() => NewItemsScreen());
                        Get.toNamed(productscreen);
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
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
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
