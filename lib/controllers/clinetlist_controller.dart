import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:invoice_maker/models/clientlist_model.dart';

import '../services/clientlist_service.dart';

class ClinetlistController extends GetxController {
  // @override
  // void onInit() {
  //   fetchSubReseller();
  //   super.onInit();
  // }

  var isLoading = false.obs;

  RxList finallist = <Client>[].obs;

  int initialpage = 1;

  var allClientList = ClientlistModel().obs;

  void fetchclients() async {
    try {
      isLoading(true);
      await ClientlistApi().fetchClientList(initialpage).then((value) {
        allClientList.value = value;

        if (allClientList.value.clients != null) {
          finallist.addAll(allClientList.value.clients ?? []);
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
