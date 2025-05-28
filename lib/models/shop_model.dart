// To parse this JSON data, do
//
//     final MyShopModel = MyShopModelFromJson(jsonString);

import 'dart:convert';

MyShopModel MyShopModelFromJson(String str) =>
    MyShopModel.fromJson(json.decode(str));

String MyShopModelToJson(MyShopModel data) => json.encode(data.toJson());

class MyShopModel {
  final bool? status;
  final String? message;
  final List<Shop>? shops;

  MyShopModel({
    this.status,
    this.message,
    this.shops,
  });

  factory MyShopModel.fromJson(Map<String, dynamic> json) => MyShopModel(
        status: json["status"],
        message: json["message"],
        shops: List<Shop>.from(json["shops"].map((x) => Shop.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "shops": List<dynamic>.from(shops!.map((x) => x.toJson())),
      };
}

class Shop {
  final int? id;
  final int? businessOwnerId;
  final String? name;
  final String? address;
  final String? phoneNumber1;
  final String? phoneNumber2;
  final String? website;
  final String? logo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Shop({
    this.id,
    this.businessOwnerId,
    this.name,
    this.address,
    this.phoneNumber1,
    this.phoneNumber2,
    this.website,
    this.logo,
    this.createdAt,
    this.updatedAt,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"] == null ? null : json["id"],
        businessOwnerId: json["business_owner_id"] == null
            ? null
            : json["business_owner_id"],
        name: json["name"] == null ? null : json["name"],
        address: json["address"] == null ? null : json["address"],
        phoneNumber1:
            json["phone_number_1"] == null ? null : json["phone_number_1"],
        phoneNumber2:
            json["phone_number_2"] == null ? null : json["phone_number_2"],
        website: json["website"] == null ? null : json["website"],
        logo: json["logo"] == null ? null : json["logo"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "business_owner_id": businessOwnerId,
        "name": name,
        "address": address,
        "phone_number_1": phoneNumber1,
        "phone_number_2": phoneNumber2,
        "website": website,
        "logo": logo,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
