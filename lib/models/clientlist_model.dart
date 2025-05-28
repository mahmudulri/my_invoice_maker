// To parse this JSON data, do
//
//     final clientlistModel = clientlistModelFromJson(jsonString);

import 'dart:convert';

ClientlistModel clientlistModelFromJson(String str) =>
    ClientlistModel.fromJson(json.decode(str));

String clientlistModelToJson(ClientlistModel data) =>
    json.encode(data.toJson());

class ClientlistModel {
  final bool? status;
  final String? message;
  final List<Client>? clients;
  final Pagination? pagination;

  ClientlistModel({
    this.status,
    this.message,
    this.clients,
    this.pagination,
  });

  factory ClientlistModel.fromJson(Map<String, dynamic> json) =>
      ClientlistModel(
        status: json["status"],
        message: json["message"],
        clients:
            List<Client>.from(json["clients"].map((x) => Client.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "clients": List<dynamic>.from(clients!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
      };
}

class Client {
  final int? id;
  final int? businessOwnerId;
  final String? name;
  final String? phoneNumber;
  final String? address;
  final dynamic? totalDue;

  Client({
    this.id,
    this.businessOwnerId,
    this.name,
    this.phoneNumber,
    this.address,
    this.totalDue,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"] == null ? null : json["id"],
        businessOwnerId: json["business_owner_id"] == null
            ? null
            : json["business_owner_id"],
        name: json["name"] == null ? null : json["name"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        address: json["address"] == null ? null : json["address"],
        totalDue: json["total_due"] == null ? null : json["total_due"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "business_owner_id": businessOwnerId,
        "name": name,
        "phone_number": phoneNumber,
        "address": address,
        "total_due": totalDue,
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
        totalItems: json["total_items"] == null ? null : json["total_items"],
        totalPages: json["total_pages"] == null ? null : json["total_pages"],
        currentPage: json["current_page"] == null ? null : json["current_page"],
        itemPerPage:
            json["item_per_page"] == null ? null : json["item_per_page"],
      );

  Map<String, dynamic> toJson() => {
        "total_items": totalItems,
        "total_pages": totalPages,
        "current_page": currentPage,
        "item_per_page": itemPerPage,
      };
}
