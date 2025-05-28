import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/clientlist_model.dart';
import '../utils/api_endpoints.dart';

class ClientlistApi {
  final box = GetStorage();

  Future<ClientlistModel> fetchClientList(int pageNo) async {
    final url = Uri.parse(
        "${ApiEndPoints.baseUrl}auth/get-clients?page=$pageNo&item_per_page=10");

    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${box.read("userToken")}',
      },
    );

    if (response.statusCode == 200) {
      print(response.statusCode.toString());
      // print("body   ... " + response.body.toString());
      final clientListModel =
          ClientlistModel.fromJson(json.decode(response.body));

      return clientListModel;
    } else {
      throw Exception('Failed to fetch gateway');
    }
  }
}
