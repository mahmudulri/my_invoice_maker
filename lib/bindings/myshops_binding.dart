import 'package:get/get.dart';

import '../controllers/myshoplist_controller.dart';

class MyshopsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyshoplistController>(() => MyshoplistController());
  }
}
