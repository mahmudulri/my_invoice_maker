import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:invoice_maker/controllers/category_controller.dart';
import 'package:invoice_maker/controllers/product_list_controller.dart';
import 'package:invoice_maker/utils/colors.dart';
import 'package:invoice_maker/widgets/custom_text.dart';
import 'package:invoice_maker/widgets/default_button.dart';

import '../controllers/add_product_controller.dart';
import '../controllers/delete_product_controller.dart';
import '../invoicecontrollers/add_item_controller.dart';
import '../invoicecontrollers/item_list_controller.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final productController = Get.find<ProductListController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productController.finallist.clear();
    productController.initialpage = 1;
    productController.fetchproduct();
  }

  AddProductController addProductController = Get.put(AddProductController());
  final AddItemController addItemController = Get.put(AddItemController());

  DeleteProductController deleteProductController =
      Get.put(DeleteProductController());

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffF1F3FF),
      appBar: AppBar(
        surfaceTintColor: Color(0xffF1F3FF),
        backgroundColor: Color(0xffF1F3FF),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Product List"),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: EdgeInsets.all(0),
                      content: AddproductBox(),
                    );
                  },
                ).then((_) {
                  addProductController.nameController.clear();
                  addProductController.unitPriceController.clear();
                  addProductController.categoryidController.clear();
                  addProductController.categoryNameController.clear();
                  addProductController.typeController.clear();
                  print("Closed");
                });
              },
              child: CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        // actions: [
        //   PopupMenuButton<String>(
        //     onSelected: (value) {
        //       // Handle menu selection
        //       print("Selected: $value");
        //     },
        //     itemBuilder: (BuildContext context) {
        //       return [
        //         PopupMenuItem(
        //           value: "settings",
        //           child: Text("Settings"),
        //         ),
        //         PopupMenuItem(
        //           value: "help",
        //           child: Text("Help"),
        //         ),
        //         PopupMenuItem(
        //           value: "logout",
        //           child: Text("Logout"),
        //         ),
        //       ];
        //     },
        //   ),
        // ],
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Container(
                height: 50,
                width: screenWidth,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey.shade400,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search product by name",
                            hintStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.search,
                        size: 35,
                        color: Colors.grey.shade600,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Expanded(
                  child: Obx(
                () => productController.isLoading.value == false
                    ? ListView.builder(
                        itemCount: productController.finallist.length,
                        itemBuilder: (context, index) {
                          final data = productController.finallist[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 8),
                            height: 70,
                            width: screenWidth,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: GestureDetector(
                                    onTap: () {
                                      addItemController.itemNameController
                                          .text = data.name.toString();
                                      addItemController.unitPriceController
                                          .text = data.unitPrice.toString();
                                      addItemController.unitOfMeasureController
                                          .text = data.unitOfMeasure.toString();
                                      addItemController
                                          .discountTypeController.text = "%";
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.transparent,
                                            contentPadding: EdgeInsets.all(0),
                                            insetPadding: EdgeInsets.all(0),
                                            content: AddCartBox(),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: screenWidth,
                                      height: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            8), // smoother curve
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(
                                                0.1), // soft shadow
                                            blurRadius: 2,
                                            spreadRadius: 2,
                                            offset: Offset(
                                                0, 2), // subtle vertical shadow
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              data.name.toString(),
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Price : "
                                                  "${data.unitPrice} Tk",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text("      -/ "),
                                                Text(
                                                  data.unitOfMeasure.toString(),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          8), // smoother curve
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withOpacity(0.1), // soft shadow
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                          offset: Offset(
                                              0, 4), // subtle vertical shadow
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(Icons.edit),
                                          Divider(),
                                          InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    contentPadding:
                                                        EdgeInsets.all(0),
                                                    content: Container(
                                                      height: 220,
                                                      width: screenWidth,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          KText(
                                                            text:
                                                                "Do you want to Delete ?",
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      DefaultButton(
                                                                    buttonName:
                                                                        "No",
                                                                    mycolor:
                                                                        Colors
                                                                            .grey,
                                                                    onpressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      DefaultButton(
                                                                    buttonName:
                                                                        "Yes",
                                                                    mycolor:
                                                                        AppColors
                                                                            .primaryColor,
                                                                    onpressed:
                                                                        () {
                                                                      deleteProductController
                                                                          .deleteproduct(data
                                                                              .id
                                                                              .toString());

                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red.shade300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              )),
              GestureDetector(
                onTap: () {
                  if (productController
                          .allproductlist.value.pagination!.currentPage ==
                      productController
                          .allproductlist.value.pagination!.totalPages) {
                    Fluttertoast.showToast(
                        msg: "No more more Products",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    productController.initialpage++;
                    productController.fetchproduct();
                  }
                },
                child: Container(
                  height: 45,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Obx(
                      () => Text(
                        productController.isLoading.value == false
                            ? "Load More"
                            : "Loading",
                        style: TextStyle(
                          fontSize: 22,
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
      ),
    );
  }
}

class AddproductBox extends StatefulWidget {
  const AddproductBox({super.key});

  @override
  State<AddproductBox> createState() => _AddproductBoxState();
}

class _AddproductBoxState extends State<AddproductBox> {
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
  String? selectedUnit;

  final categorycontroller = Get.find<CategoryController>();

  AddProductController addProductController = Get.put(AddProductController());

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 550,
      width: screenWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                KText(
                  text: "Product Name",
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    size: 30,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              width: screenWidth,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: addProductController.nameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter product name",
                    hintStyle: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            KText(
              text: "Unit Price",
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              width: screenWidth,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: addProductController.unitPriceController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter unit price",
                    hintStyle: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            KText(
              text: "Unit Of Measure",
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              width: screenWidth,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: addProductController.typeController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter or select unit',
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.arrow_drop_down),
                    onSelected: (String value) {
                      setState(() {
                        addProductController.typeController.text = value;
                        addProductController.typeController.text = value;
                      });
                    },
                    itemBuilder: (BuildContext context) {
                      return unitTypes.map((String unit) {
                        return PopupMenuItem<String>(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            KText(
              text: "Product Category",
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              width: screenWidth,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      controller: addProductController.categoryNameController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Select Category',
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                      icon: const Icon(Icons.arrow_drop_down),
                      onSelected: (String value) {
                        final selectedCategory = categorycontroller
                            .allcategorylist.value.productCategories!
                            .firstWhere((cat) => cat.id.toString() == value);

                        setState(() {
                          addProductController.categoryidController.text =
                              selectedCategory.id.toString(); // internal use
                          addProductController.categoryNameController.text =
                              selectedCategory.name.toString(); // show
                        });
                        print(
                            "Selected ID: ${addProductController.categoryidController.text}");
                        print(
                            "Selected Name: ${addProductController.categoryNameController.text}");
                      },
                      itemBuilder: (BuildContext context) {
                        return categorycontroller
                            .allcategorylist.value.productCategories!
                            .map((category) {
                          return PopupMenuItem<String>(
                            value: category.id
                                .toString(), // access the string field
                            child: Text(
                              category.name.toString(),
                            ),
                          );
                        }).toList();
                      }),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Obx(
              () => DefaultButton(
                buttonName: addProductController.isLoading.value == false
                    ? "Add Now"
                    : "Please wait..",
                mycolor: AppColors.primaryColor,
                onpressed: () async {
                  if (addProductController.nameController.text.isNotEmpty &&
                      addProductController
                          .unitPriceController.text.isNotEmpty &&
                      addProductController.typeController.text.isNotEmpty &&
                      addProductController
                          .categoryidController.text.isNotEmpty) {
                    await addProductController.addProduct();
                  } else {
                    print("Not Filled");
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

//......................................Add Cart Box........................//

class AddCartBox extends StatefulWidget {
  AddCartBox({super.key});

  @override
  State<AddCartBox> createState() => _AddCartBoxState();
}

class _AddCartBoxState extends State<AddCartBox> {
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
  final AddItemController addItemController = Get.put(AddItemController());
  final ItemListController itemListController = Get.put(ItemListController());

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 550,
        width: screenWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
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
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: TextFormField(
                      readOnly: true,
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
              ),

              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    "Unit Price",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
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
                    readOnly: true,
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
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          child: Center(
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
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
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
                          child: Center(
                            child: TextField(
                              readOnly: true,
                              controller:
                                  addItemController.unitOfMeasureController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
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
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  readOnly: true,
                                  controller:
                                      addItemController.discountTypeController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              // GestureDetector(
                              //   onTap: () {
                              //     showDialog(
                              //       context: context,
                              //       builder: (context) {
                              //         return AlertDialog(
                              //           backgroundColor: Colors.transparent,
                              //           contentPadding: EdgeInsets.all(0.0),
                              //           content: Container(
                              //             height: 110,
                              //             width: screenWidth,
                              //             decoration: BoxDecoration(
                              //               color: Colors.white,
                              //               borderRadius:
                              //                   BorderRadius.circular(10),
                              //             ),
                              //             child: Padding(
                              //               padding: EdgeInsets.all(8.0),
                              //               child: ListView.builder(
                              //                 physics: BouncingScrollPhysics(),
                              //                 itemCount: discountType.length,
                              //                 itemBuilder: (context, index) {
                              //                   return GestureDetector(
                              //                     onTap: () {
                              //                       // ignore: unrelated_type_equality_checks
                              //                       addItemController
                              //                               .discountTypeController
                              //                               .text =
                              //                           discountType[index];
                              //                       addItemController
                              //                           .calculateTotalPrice();

                              //                       Navigator.pop(context);
                              //                     },
                              //                     child: Container(
                              //                       margin: EdgeInsets.only(
                              //                           bottom: 5),
                              //                       height: 40,
                              //                       width: screenWidth,
                              //                       decoration: BoxDecoration(
                              //                         color: Colors.white,
                              //                         borderRadius:
                              //                             BorderRadius.circular(
                              //                                 8),
                              //                         border: Border.all(
                              //                           width: 1,
                              //                           color: Colors
                              //                               .grey.shade300,
                              //                         ),
                              //                       ),
                              //                       child: Center(
                              //                         child: Text(
                              //                           discountType[index],
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   );
                              //                 },
                              //               ),
                              //             ),
                              //           ),
                              //         );
                              //       },
                              //     );
                              //   },
                              //   child: Container(
                              //     width: 40,
                              //     decoration: BoxDecoration(
                              //       color: Colors.grey,
                              //       borderRadius: BorderRadius.circular(5),
                              //     ),
                              //     child: Center(
                              //       child: Icon(
                              //         Icons.arrow_downward,
                              //         color: Colors.white,
                              //       ),
                              //     ),
                              //   ),
                              // ),
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
                        addItemController.itemNameController.clear();
                        addItemController.unitPriceController.clear();
                        addItemController.unitOfMeasureController.clear();
                        addItemController.quantityController.clear();

                        Navigator.pop(context);
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
