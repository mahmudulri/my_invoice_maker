import 'package:get/get.dart';

import '../controllers/clinetlist_controller.dart';

class ClientlistBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClinetlistController>(() => ClinetlistController());
  }
}
