import 'package:get/get.dart';
import '../models/category_model.dart';
import '../models/shop_model.dart';
import '../services/category_service.dart';
import '../services/myshop_service.dart';

class CategoryController extends GetxController {
  var isLoading = false.obs;

  var allcategorylist = CategoryModel().obs;

  void fetchcategorylist() async {
    try {
      isLoading(true);
      await CategorylistApi().fetchcategory().then((value) {
        allcategorylist.value = value;

        isLoading(false);
      });

      isLoading(false);
    } catch (e) {
      print(e.toString());
    }
  }
}
