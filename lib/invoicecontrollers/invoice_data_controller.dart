import 'package:get/get.dart';

class InvoiceDataController extends GetxController {
  String invoiceStatus = 'Status';
  RxString dueDate = ''.obs;
  RxString imagelink = 'assets/icons/paid.png'.obs;
}
