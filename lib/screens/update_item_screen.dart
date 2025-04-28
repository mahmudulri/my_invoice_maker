import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_item_controller.dart';
import '../controllers/item_list_controller.dart';

class EditItemScreen extends StatelessWidget {
  final int index; // Index of the item in the list
  EditItemScreen({super.key, required this.index});

  // final AddItemController addItemController = Get.find<AddItemController>();
  // final ItemListController itemListController = Get.find<ItemListController>();

  final AddItemController addItemController = Get.put(AddItemController());
  final ItemListController itemListController = Get.put(ItemListController());

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    // Get the item from the list
    var item = itemListController.itemlist[index];

    // Pre-fill controllers with item data
    addItemController.itemNameController.text = item["name"];
    addItemController.unitPriceController.text = item["unitprice"];
    addItemController.quantityController.text = item["quantity"];
    addItemController.unitOfMeasureController.text = item["unitofmeasure"];
    addItemController.discountTypeController.text = item["discounttype"];
    addItemController.unitVatController.text = item["vat"];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Edit Item",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        padding: EdgeInsets.all(18.0),
        child: Column(
          children: [
            // Item Name Field
            _buildTextField(
              controller: addItemController.itemNameController,
              hintText: "Item Name",
            ),

            SizedBox(height: 5),

            // Item Price Field
            _buildTextField(
              controller: addItemController.unitPriceController,
              hintText: "Item Price",
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 5),

            // Quantity & Unit of Measure
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: _buildTextField(
                    controller: addItemController.quantityController,
                    hintText: "Quantity",
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: _buildTextField(
                    controller: addItemController.unitOfMeasureController,
                    hintText: "Unit of Measure",
                  ),
                ),
              ],
            ),

            SizedBox(height: 5),

            // Discount & Discount Type
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: _buildTextField(
                    controller: addItemController.unitDiscountController,
                    hintText: "Discount",
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: _buildTextField(
                    controller: addItemController.discountTypeController,
                    hintText: "Discount Type",
                  ),
                ),
              ],
            ),

            SizedBox(height: 5),

            // VAT Field
            _buildTextField(
              controller: addItemController.unitVatController,
              hintText: "VAT %",
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 10),

            // Total Price Display
            Container(
              height: 45,
              width: screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total: ",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white)),
                  Obx(
                    () => Text(
                      addItemController.itemTotalPrice.value.toString(),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),

            // Buttons: Cancel, Delete, Update
            Row(
              children: [
                _buildButton(
                  text: "Cancel",
                  color: Colors.grey,
                  onTap: () => Get.back(),
                ),
                SizedBox(width: 10),
                _buildButton(
                  text: "Delete",
                  color: Colors.red,
                  onTap: () {
                    itemListController.deleteItem(index);
                    Get.back();
                  },
                ),
                SizedBox(width: 10),
                _buildButton(
                  text: "Update",
                  color: Colors.green,
                  onTap: () {
                    _updateItem(index);
                    Get.back();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Update item method
  void _updateItem(int index) {
    itemListController.updateItem(
      index,
      {
        "name": addItemController.itemNameController.text,
        "unitprice": addItemController.unitPriceController.text,
        "quantity": addItemController.quantityController.text,
        "unitofmeasure": addItemController.unitOfMeasureController.text,
        "discount": addItemController.discountTypeController.text,
        "discounttype": addItemController.discountTypeController.text,
        "vat": addItemController.unitVatController.text,
        "total": addItemController.itemTotalPrice.toString(),
      },
    );
  }

  // Widget for Text Field
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: Colors.grey.shade300),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration:
            InputDecoration(border: InputBorder.none, hintText: hintText),
      ),
    );
  }

  // Widget for Buttons
  Widget _buildButton(
      {required String text,
      required Color color,
      required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(text,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17)),
          ),
        ),
      ),
    );
  }
}
