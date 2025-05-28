import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/category_model.dart';
import '../utils/api_endpoints.dart';

class CategorylistApi {
  final box = GetStorage();

  Future<CategoryModel> fetchcategory() async {
    final url = Uri.parse("${ApiEndPoints.baseUrl}product-categories");

    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${box.read("userToken")}',
      },
    );

    if (response.statusCode == 200) {
      // print(response.statusCode.toString());
      // print("body   ... " + response.body.toString());
      final categoryModel = CategoryModel.fromJson(json.decode(response.body));

      return categoryModel;
    } else {
      throw Exception('Failed to fetch gateway');
    }
  }
}
