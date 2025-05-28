import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  final bool? status;
  final String? message;
  final List<ProductCategory>? productCategories;

  CategoryModel({
    this.status,
    this.message,
    this.productCategories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        status: json["status"],
        message: json["message"],
        productCategories: List<ProductCategory>.from(
            json["product_categories"].map((x) => ProductCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "product_categories":
            List<dynamic>.from(productCategories!.map((x) => x.toJson())),
      };
}

class ProductCategory {
  final int? id;
  final String? name;

  ProductCategory({
    this.id,
    this.name,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
