import 'package:get/get.dart';

class InvoiceDataController extends GetxController {
  String invoiceStatus = 'Unpaid';
  RxString dueDate = ''.obs;
  RxString imagelink = 'assets/icons/paid.png'.obs;
}
