import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/clientlist_model.dart';
import '../models/shop_model.dart';
import '../utils/api_endpoints.dart';

class MyshoplistApi {
  final box = GetStorage();

  Future<MyShopModel> fetchsholist() async {
    final url = Uri.parse("${ApiEndPoints.baseUrl}shops");

    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${box.read("userToken")}',
      },
    );

    if (response.statusCode == 200) {
      print(response.statusCode.toString());
      // print("body   ... " + response.body.toString());
      final myshoplistmodel = MyShopModel.fromJson(json.decode(response.body));

      return myshoplistmodel;
    } else {
      throw Exception('Failed to fetch gateway');
    }
  }
}
