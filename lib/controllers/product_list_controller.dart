import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:invoice_maker/models/clientlist_model.dart';

import '../models/product_model.dart';
import '../services/clientlist_service.dart';
import '../services/product_list_service.dart';

class ProductListController extends GetxController {
  // @override
  // void onInit() {
  //   fetchSubReseller();
  //   super.onInit();
  // }

  var isLoading = false.obs;

  RxList finallist = <Product>[].obs;

  int initialpage = 1;

  var allproductlist = ProductModel().obs;

  void fetchclients() async {
    try {
      isLoading(true);
      await ProdcutlistApi().fetchproductlist(initialpage).then((value) {
        allproductlist.value = value;

        if (allproductlist.value.products != null) {
          finallist.addAll(allproductlist.value.products ?? []);
        }

        // finallist.forEach((clients) {
        //   print(clients.id.toString());
        // });

        isLoading(false);
      });

      isLoading(false);
    } catch (e) {
      print(e.toString());
    }
  }
}
