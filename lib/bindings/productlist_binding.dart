import 'package:get/get.dart';

import '../controllers/clinetlist_controller.dart';
import '../controllers/product_list_controller.dart';

class ProductlistBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductListController>(() => ProductListController());
  }
}
