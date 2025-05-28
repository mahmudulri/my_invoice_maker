import 'package:get/get.dart';
import '../models/shop_model.dart';
import '../services/myshop_service.dart';

class MyshoplistController extends GetxController {
  var isLoading = false.obs;

  var allshoplist = MyShopModel().obs;

  void fetchshop() async {
    try {
      isLoading(true);
      await MyshoplistApi().fetchsholist().then((value) {
        allshoplist.value = value;

        isLoading(false);
      });

      isLoading(false);
    } catch (e) {
      print(e.toString());
    }
  }
}
