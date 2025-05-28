import 'package:get/get.dart';

import '../controllers/sign_in_controller.dart';

class SigninBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
  }
}
