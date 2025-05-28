import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddItemController extends GetxController {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController unitPriceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController unitOfMeasureController = TextEditingController();
  TextEditingController unitDiscountController = TextEditingController();

  TextEditingController discountTypeController = TextEditingController();
  TextEditingController unitVatController = TextEditingController();

  // Make the itemTotalPrice observable
  var itemTotalPrice = '0'.obs;
  String unitofmeasure = "";
  String discountType = "";

  void calculateTotalPrice() {
    double unitPrice = double.tryParse(unitPriceController.text) ?? 0.0;

    // Default to quantity 1 if quantity is not set or is zero
    double quantity = double.tryParse(quantityController.text) ?? 1;
    quantity = quantity == 0 ? 1.0 : quantity;

    double discount = double.tryParse(unitDiscountController.text) ?? 0.0;
    double vat = double.tryParse(unitVatController.text) ?? 0.0;

    // Calculate price before discount
    double priceBeforeDiscount = unitPrice * quantity;

    // Check discount type (default to percentage if not set)
    String discountType =
        discountTypeController.text.isEmpty ? '%' : discountTypeController.text;

    if (discountType == '%') {
      priceBeforeDiscount -= (priceBeforeDiscount * discount / 100);
    } else if (discountType == 'flat') {
      priceBeforeDiscount -= discount;
    }

    // Calculate VAT and add to total price
    double vatAmount = priceBeforeDiscount * (vat / 100);
    double totalPrice = priceBeforeDiscount + vatAmount;

    // Update the total price (use .value to update the observable)
    itemTotalPrice.value = totalPrice.toStringAsFixed(2);
  }
}
