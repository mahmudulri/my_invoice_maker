// ignore_for_file: unnecessary_null_comparison

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:invoice_maker/controllers/address_controller.dart';
import 'package:invoice_maker/controllers/billto_controller.dart';
import 'package:invoice_maker/controllers/demoitems_controller.dart';
import 'package:invoice_maker/controllers/invoice_data_controller.dart';
import 'package:invoice_maker/controllers/item_list_controller.dart';
import 'package:invoice_maker/templates/template-1.dart';
import 'package:invoice_maker/utils/colors.dart';
import 'dart:ui' as ui;
import 'package:image_gallery_saver/image_gallery_saver.dart';

class DesignOneTemplate extends StatelessWidget {
  DesignOneTemplate({super.key});
  final InvoiceDataController invoiceDataController =
      Get.put(InvoiceDataController());

  // final ItemListController itemListController = Get.put(ItemListController());

  ItemListController itemListController = Get.put(ItemListController());

  final BusinessAddressController businessAddressController = Get.put(
    BusinessAddressController(),
  );

  // final ClientAddressController clientAddressController =
  //     Get.put(ClientAddressController());

  final BilltoController billtoController = Get.put(BilltoController());

  // ........................................Making Png Image..................................//
  GlobalKey _catpureKey = GlobalKey();

  Future<void> _capturePng() async {
    try {
      RenderRepaintBoundary boundary = _catpureKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary;
      if (boundary != null) {
        ui.Image image = await boundary.toImage(pixelRatio: 3.0);
        ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        if (byteData != null) {
          Uint8List pngBytes = byteData.buffer.asUint8List();

          // Save to gallery
          final result = await ImageGallerySaver.saveImage(pngBytes,
              quality: 100, name: "screenshot");
          print(result);
          Get.snackbar(
            "SUCCESS",
            "SAVED IMAGE TO GALLERY",
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }

  String generateUniqueId() {
    String formattedDate = DateFormat('ddMMM').format(DateTime.now());

    int randomNumber = Random().nextInt(900) + 100;

    String uniqueId = "$formattedDate$randomNumber";

    return uniqueId;
  }

  @override
  Widget build(BuildContext context) {
    String uniqueId = generateUniqueId();
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // key: _catpureKey,
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
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                print(itemListController.itemlist.length);
              },
              child: Text(
                "Preview 1",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () async {
                _capturePng();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey.shade300,
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Center(
                      child: Text(
                    "Save",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
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
                // itemListController.itemlist.clear();
                // Get.back();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey.shade300,
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Center(
                      child: Text(
                    "Store",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
      body: RepaintBoundary(
        key: _catpureKey,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.red,
                ),
              ),
              height: screenHeight,
              width: screenWidth,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                businessAddressController
                                            .businessNameController.text ==
                                        null
                                    ? "Business Name"
                                    : businessAddressController
                                        .businessNameController.text
                                        .toString(),
                                style: TextStyle(
                                  color: AppColors.defaultTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    businessAddressController
                                                .address1Controller ==
                                            null
                                        ? ""
                                        : businessAddressController
                                            .address1Controller.text
                                            .toString(),
                                    style: TextStyle(
                                      color: AppColors.defaultTextColor,
                                      fontSize: 11,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    businessAddressController
                                                .address2Controller ==
                                            null
                                        ? ""
                                        : businessAddressController
                                            .address2Controller.text
                                            .toString(),
                                    style: TextStyle(
                                      color: AppColors.defaultTextColor,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                businessAddressController
                                            .phoneNumberController ==
                                        null
                                    ? "Business Phone"
                                    : businessAddressController
                                        .phoneNumberController.text
                                        .toString(),
                                style: TextStyle(
                                  color: AppColors.defaultTextColor,
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                businessAddressController.websiteController ==
                                        null
                                    ? "Website"
                                    : businessAddressController
                                        .websiteController.text
                                        .toString(),
                                style: TextStyle(
                                  color: AppColors.defaultTextColor,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "BILL TO-",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      Divider(
                        color: Colors.grey.shade400,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 7,
                            child: Container(
                              // color: Colors.red,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    billtoController.nameController == null
                                        ? "Client Name"
                                        : billtoController.nameController.text
                                            .toString(),
                                    style: TextStyle(
                                      color: AppColors.defaultTextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        billtoController.address1Controller ==
                                                null
                                            ? "Client Address"
                                            : billtoController
                                                .address1Controller.text
                                                .toString(),
                                        style: TextStyle(
                                          color: AppColors.defaultTextColor,
                                          fontSize: 11,
                                        ),
                                      ),
                                      Text(
                                        billtoController.address2Controller ==
                                                null
                                            ? ""
                                            : billtoController
                                                .address2Controller.text
                                                .toString(),
                                        style: TextStyle(
                                          color: AppColors.defaultTextColor,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    billtoController.phoneNumberController ==
                                            null
                                        ? "Client Phone"
                                        : billtoController
                                            .phoneNumberController.text
                                            .toString(),
                                    style: TextStyle(
                                      color: AppColors.defaultTextColor,
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    billtoController.websiteController == null
                                        ? "Client Website"
                                        : billtoController
                                            .websiteController.text
                                            .toString(),
                                    style: TextStyle(
                                      color: AppColors.defaultTextColor,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              // color: Colors.blue,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Date :",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                      ),
                                      Text(
                                        "${DateFormat('yyyy-MM-dd').format(DateTime.now())}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Invoice ID : ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                      ),
                                      Text(
                                        uniqueId.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "STATUS : ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: invoiceDataController
                                                      .invoiceStatus ==
                                                  null
                                              ? Colors.grey.shade400
                                              : invoiceDataController
                                                          .invoiceStatus
                                                          .toString() ==
                                                      "Paid"
                                                  ? Colors.green
                                                  : invoiceDataController
                                                              .invoiceStatus
                                                              .toString() ==
                                                          "Due"
                                                      ? Colors.yellow
                                                      : Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 3),
                                          child: Text(
                                            invoiceDataController
                                                        .invoiceStatus ==
                                                    null
                                                ? "Status"
                                                : invoiceDataController
                                                    .invoiceStatus
                                                    .toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                              color: Colors.white,
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
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: 20,
                              width: screenWidth,
                              decoration: BoxDecoration(
                                color: Colors.red.shade300,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Center(
                                      child: Text(
                                        "Name",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  VerticalDivider(
                                    thickness: 2,
                                    color: Colors.white,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Text(
                                        "Qty",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  VerticalDivider(
                                    thickness: 2,
                                    color: Colors.white,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Text(
                                        "Unit P.",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  VerticalDivider(
                                    thickness: 2,
                                    color: Colors.white,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: Text(
                                        "Total",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Expanded(
                              child: Container(
                                // color: Colors.green,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Obx(
                                    () => itemListController.itemlist.isNotEmpty
                                        ? ListView.separated(
                                            separatorBuilder: (context, index) {
                                              return SizedBox(height: 3);
                                            },
                                            itemCount: itemListController
                                                .itemlist.length,
                                            itemBuilder: (context, index) {
                                              double getTotalPrice() {
                                                double totalPrice = 0.0;

                                                for (var item
                                                    in itemListController
                                                        .itemlist) {
                                                  double itemTotal =
                                                      double.tryParse(item[
                                                                  "total"]
                                                              .toString()) ??
                                                          0.0;
                                                  totalPrice += itemTotal;
                                                }

                                                return totalPrice;
                                              }

                                              final data = itemListController
                                                  .itemlist[index];
                                              return Container(
                                                width: screenWidth,
                                                decoration: BoxDecoration(
                                                  color: index % 2 == 1
                                                      ? Colors.grey.shade50
                                                      : Colors.red.shade50,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 4,
                                                        child: Text(
                                                          data["name"],
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 10),
                                                          child: Text(
                                                            data["quantity"],
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 5),
                                                          child: Text(
                                                            data["unitprice"],
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          data["total"],
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        : Center(
                                            child: Text(
                                              "No Items",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 90,
                        width: screenWidth,
                        decoration: BoxDecoration(
                            // color: Colors.cyan,
                            ),
                        child: Column(
                          children: [
                            Container(
                              height: 1,
                              width: double.maxFinite,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Total : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  itemListController.totalPrice.value
                                      .toStringAsFixed(2),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Discount (${itemListController.discount}%) : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  itemListController.discountedPrice.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Tax (${itemListController.tax}%%) : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  itemListController.taxmount.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Container(
                              height: 1,
                              width: screenWidth,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Subtotal : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13,
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
                                            fontSize: 13,
                                          ),
                                        )
                                      : Text("calculating"),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
