import 'package:get/get.dart';

class ItemListController extends GetxController {
  double discount = 0;
  double discountedPrice = 0;
  double tax = 0.0;
  double taxmount = 0.0;
  double shippingcost = 0.0;

  RxBool isloading = false.obs;
  RxBool subtotalloading = false.obs;

  RxList<Map<String, dynamic>> itemlist = <Map<String, dynamic>>[].obs;
  RxDouble subTotalPrice = 0.0.obs; // Store subtotal as reactive
  RxDouble totalPrice = 0.0.obs; // Store final price as reactive

  void addItem(Map<String, dynamic> newItem) {
    itemlist.add(newItem);
    calculateTotalPrice(); // Recalculate when items are added
  }

  void updateItem(int index, Map<String, dynamic> updatedItem) {
    itemlist[index] = updatedItem;
    itemlist.refresh();
    calculateTotalPrice(); // Recalculate when items are updated
  }

  void deleteItem(int index) {
    itemlist.removeAt(index);
    calculateTotalPrice(); // Recalculate when items are removed
  }

  void calculateTotalPrice() {
    isloading.value = true; // Start loading

    subTotalPrice.value = 0.0;
    for (var item in itemlist) {
      double itemTotal = double.tryParse(item["total"].toString()) ?? 0;
      subTotalPrice.value += itemTotal;
    }

    // Apply discount
    double discountAmount = (subTotalPrice.value * discount) / 100;
    discountedPrice = discountAmount;
    double priceAfterDiscount = subTotalPrice.value - discountAmount;

    // Apply tax
    taxmount = (priceAfterDiscount * tax) / 100;
    totalPrice.value = priceAfterDiscount + taxmount; // Update total price

    // Calculate total price including tax and shipping
    totalPrice.value = priceAfterDiscount + taxmount + shippingcost;

    isloading.value = false; // Stop loading
  }
}
