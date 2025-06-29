// To parse this JSON data, do
//
//     final sellingpriceModel = sellingpriceModelFromJson(jsonString);

import 'dart:convert';

SellingpriceModel sellingpriceModelFromJson(String str) =>
    SellingpriceModel.fromJson(json.decode(str));

String sellingpriceModelToJson(SellingpriceModel data) =>
    json.encode(data.toJson());

class SellingpriceModel {
  final bool status;
  final String message;
  final BusinessOwner businessOwner;

  SellingpriceModel({
    required this.status,
    required this.message,
    required this.businessOwner,
  });

  factory SellingpriceModel.fromJson(Map<String, dynamic> json) =>
      SellingpriceModel(
        status: json["status"],
        message: json["message"],
        businessOwner: BusinessOwner.fromJson(json["business_owner"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "business_owner": businessOwner.toJson(),
      };
}

class BusinessOwner {
  final int? id;
  final String? name;
  final String? address;
  final String? phoneNumber;
  final String? thumbnailImage;
  final dynamic currency;
  final dynamic totalSalesAmount;
  final dynamic totalUnpaidAmount;
  final String? password;
  final DateTime? dateOfBirth;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BusinessOwner({
    this.id,
    this.name,
    this.address,
    this.phoneNumber,
    this.thumbnailImage,
    this.currency,
    this.totalSalesAmount,
    this.totalUnpaidAmount,
    this.password,
    this.dateOfBirth,
    this.createdAt,
    this.updatedAt,
  });

  factory BusinessOwner.fromJson(Map<String, dynamic> json) => BusinessOwner(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        address: json["address"] == null ? null : json["address"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        thumbnailImage:
            json["thumbnail_image"] == null ? null : json["thumbnail_image"],
        currency: json["currency"] == null ? null : json["currency"],
        totalSalesAmount: json["total_sales_amount"] == null
            ? null
            : json["total_sales_amount"],
        totalUnpaidAmount: json["total_unpaid_amount"] == null
            ? null
            : json["total_unpaid_amount"],
        password: json["password"] == null ? null : json["password"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "phone_number": phoneNumber,
        "thumbnail_image": thumbnailImage,
        "currency": currency,
        "total_sales_amount": totalSalesAmount,
        "total_unpaid_amount": totalUnpaidAmount,
        "password": password,
        "date_of_birth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
