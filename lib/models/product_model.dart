// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  final bool? status;
  final String? message;
  final List<Product>? products;
  final Pagination? pagination;

  ProductModel({
    this.status,
    this.message,
    this.products,
    this.pagination,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        status: json["status"],
        message: json["message"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
        "pagination": pagination!.toJson(),
      };
}

class Pagination {
  final int? totalItems;
  final int? totalPages;
  final int? currentPage;
  final int? itemPerPage;

  Pagination({
    this.totalItems,
    this.totalPages,
    this.currentPage,
    this.itemPerPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalItems: json["total_items"],
        totalPages: json["total_pages"],
        currentPage: json["current_page"],
        itemPerPage: json["item_per_page"],
      );

  Map<String, dynamic> toJson() => {
        "total_items": totalItems,
        "total_pages": totalPages,
        "current_page": currentPage,
        "item_per_page": itemPerPage,
      };
}

class Product {
  final int? id;
  final int? businessOwnerId;
  final int? productCategoryId;
  final String? name;
  final double? unitPrice;
  final String? unitOfMeasure;

  Product({
    this.id,
    this.businessOwnerId,
    this.productCategoryId,
    this.name,
    this.unitPrice,
    this.unitOfMeasure,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        businessOwnerId: json["business_owner_id"],
        productCategoryId: json["product_category_id"],
        name: json["name"],
        unitPrice: (json["unit_price"] as num).toDouble(),
        unitOfMeasure: json["unit_of_measure"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "business_owner_id": businessOwnerId,
        "product_category_id": productCategoryId,
        "name": name,
        "unit_price": unitPrice,
        "unit_of_measure": unitOfMeasure,
      };
}
