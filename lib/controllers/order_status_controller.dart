// controllers/order_status_controller.dart
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OrderStatusController extends GetxController {
  var orderId = ''.obs;
  var status = ''.obs;

  final box = GetStorage();

  void loadFromStorage() {
    orderId.value = box.read("orderID") ?? "";
    status.value = box.read("orderStatus") ?? "";
  }

  void updateOrder(String newId, String newStatus) {
    orderId.value = newId;
    status.value = newStatus;
    box.write("orderID", newId);
    box.write("orderStatus", newStatus);
  }
}
