import 'package:get/get.dart';

class ItemListController extends GetxController {
  double discount = 0.0;
  double discountedPrice = 0.0;
  double tax = 0.0;
  double taxmount = 0.0;
  double shippingcost = 0.0;

  RxDouble paidAmount = 0.0.obs; // ✅ Reactive paid amount
  RxDouble dueamount = 0.0.obs; // ✅ Reactive due amount

  RxBool isloading = false.obs;
  RxBool subtotalloading = false.obs;

  RxList<Map<String, dynamic>> itemlist = <Map<String, dynamic>>[].obs;

  RxDouble subTotalPrice = 0.0.obs;
  RxDouble totalPrice = 0.0.obs;

  void addItem(Map<String, dynamic> newItem) {
    itemlist.add(newItem);
    calculateTotalPrice();
  }

  void updateItem(int index, Map<String, dynamic> updatedItem) {
    itemlist[index] = updatedItem;
    itemlist.refresh();
    calculateTotalPrice();
  }

  void deleteItem(int index) {
    itemlist.removeAt(index);
    calculateTotalPrice();
  }

  void calculateTotalPrice() {
    isloading.value = true;

    subTotalPrice.value = 0.0;

    for (var item in itemlist) {
      double itemTotal = double.tryParse(item["total"].toString()) ?? 0;
      subTotalPrice.value += itemTotal;
    }

    double discountAmount = (subTotalPrice.value * discount) / 100;
    discountedPrice = discountAmount;
    double priceAfterDiscount = subTotalPrice.value - discountAmount;

    taxmount = (priceAfterDiscount * tax) / 100;

    totalPrice.value = priceAfterDiscount + taxmount + shippingcost;

    calculateDueAmount(); // ✅ Update due whenever total changes

    isloading.value = false;
  }

  void updatePaidAmount(double amount) {
    paidAmount.value = amount;
    calculateDueAmount(); // ✅ Recalculate due based on new paid amount
  }

  void calculateDueAmount() {
    dueamount.value = totalPrice.value - paidAmount.value;
    if (dueamount.value < 0) {
      dueamount.value = 0.0;
    }
  }
}
