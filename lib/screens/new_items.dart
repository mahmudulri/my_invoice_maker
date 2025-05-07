import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:invoice_maker/draft/draft.dart';

import '../controllers/add_item_controller.dart';
import '../controllers/item_list_controller.dart';

class NewItemsScreen extends StatelessWidget {
  NewItemsScreen({super.key});

  final AddItemController addItemController = Get.put(AddItemController());

  List<String> unitTypes = [
    'Box',
    'Packet',
    'Carton',
    'Piece',
    'Dozen',
    'Bundle',
    'Kg',
    'Gram (G)',
    'Litter',
    'Ml',
    'Case',
    'Pallet',
    'Roll',
    'Set',
    'Barrel',
  ];

  List<String> discountType = [
    'Flat',
    '%',
  ];

  final ItemListController itemListController = Get.put(ItemListController());

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
          "Add New Item",
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
            horizontal: 18,
          ),
          child: Column(
            children: [
              Container(
                height: 50,
                width: screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey.shade300,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.text,
                    controller: addItemController.itemNameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Item Name",
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 5,
              ),
              Container(
                height: 50,
                width: screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey.shade300,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    onChanged: (value) {
                      addItemController.calculateTotalPrice();
                    },
                    controller: addItemController.unitPriceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Item Price",
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              SizedBox(
                width: screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Quantity",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Unit of measure",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Container(
                height: 45,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        // height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          child: TextField(
                            onChanged: (value) {
                              addItemController.calculateTotalPrice();
                            },
                            controller: addItemController.quantityController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "0",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller:
                                      addItemController.unitOfMeasureController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.transparent,
                                        contentPadding: EdgeInsets.all(0.0),
                                        content: Container(
                                          height: 400,
                                          width: screenWidth,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ListView.builder(
                                              physics: BouncingScrollPhysics(),
                                              itemCount: unitTypes.length,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    // ignore: unrelated_type_equality_checks
                                                    addItemController
                                                        .unitOfMeasureController
                                                        .text = unitTypes[
                                                            index]
                                                        .toString();
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 5),
                                                    height: 40,
                                                    width: screenWidth,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                        width: 1,
                                                        color: Colors
                                                            .grey.shade300,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        unitTypes[index]
                                                            .toString(),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_downward,
                                      color: Colors.white,
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
              SizedBox(
                height: 3,
              ),
              Container(
                width: screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Discount",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Discount Type",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 3,
              ),

              Container(
                height: 45,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        // height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          child: TextField(
                            onChanged: (value) {
                              addItemController.calculateTotalPrice();
                            },
                            controller:
                                addItemController.unitDiscountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "0",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        // height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller:
                                      addItemController.discountTypeController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.transparent,
                                        contentPadding: EdgeInsets.all(0.0),
                                        content: Container(
                                          height: 110,
                                          width: screenWidth,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: ListView.builder(
                                              physics: BouncingScrollPhysics(),
                                              itemCount: discountType.length,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    // ignore: unrelated_type_equality_checks
                                                    addItemController
                                                            .discountTypeController
                                                            .text =
                                                        discountType[index];
                                                    addItemController
                                                        .calculateTotalPrice();

                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 5),
                                                    height: 40,
                                                    width: screenWidth,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                        width: 1,
                                                        color: Colors
                                                            .grey.shade300,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        discountType[index],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_downward,
                                      color: Colors.white,
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
              SizedBox(
                height: 3,
              ),

              ///..................................................//
              Container(
                width: screenWidth,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Vat %",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 5,
              // ),
              SizedBox(
                height: 3,
              ),
              Container(
                height: 45,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          child: TextField(
                            onChanged: (value) {
                              addItemController.calculateTotalPrice();
                            },
                            controller: addItemController.unitVatController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "0",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
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

              Container(
                height: 45,
                width: screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total : ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      Obx(
                        () => Text(
                          addItemController.itemTotalPrice.value.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () async {
                        if (addItemController.itemNameController.text.isNotEmpty &&
                            addItemController
                                .unitPriceController.text.isNotEmpty &&
                            addItemController
                                .quantityController.text.isNotEmpty &&
                            addItemController
                                .unitOfMeasureController.text.isNotEmpty) {
                          Map<String, dynamic> newItem = {
                            "name": addItemController.itemNameController.text,
                            "unitprice":
                                addItemController.unitPriceController.text,
                            "quantity":
                                addItemController.quantityController.text,
                            "unitofmeasure":
                                addItemController.unitOfMeasureController.text,
                            "discount":
                                addItemController.unitDiscountController.text,
                            "discounttype":
                                addItemController.discountTypeController.text,
                            "vat": addItemController.unitVatController.text,
                            "total":
                                addItemController.itemTotalPrice.toString(),
                          };
                          itemListController.addItem(newItem);
                          itemListController.calculateTotalPrice();
                          itemListController.calculateTotalPrice();

                          Get.back();
                        } else {
                          Get.snackbar(
                            "Attention",
                            "Add required data must",
                          );
                        }
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Add Now",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
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
  }
}
