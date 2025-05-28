import 'package:get/get.dart';
import 'package:invoice_maker/controllers/category_controller.dart';
import 'package:invoice_maker/controllers/clinetlist_controller.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryController>(() => CategoryController());
  }
}
