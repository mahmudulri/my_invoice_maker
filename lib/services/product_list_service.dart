import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/clientlist_model.dart';
import '../models/product_model.dart';
import '../utils/api_endpoints.dart';

class ProdcutlistApi {
  final box = GetStorage();

  Future<ProductModel> fetchproductlist(int pageNo) async {
    final url = Uri.parse(
        "${ApiEndPoints.baseUrl}products?page=$pageNo&item_per_page=10");

    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${box.read("userToken")}',
      },
    );

    if (response.statusCode == 200) {
      // print(response.statusCode.toString());
      // print("body   ... " + response.body.toString());
      final productlistModel =
          ProductModel.fromJson(json.decode(response.body));

      return productlistModel;
    } else {
      throw Exception('Failed to fetch gateway');
    }
  }
}
