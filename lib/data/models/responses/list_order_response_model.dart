// To parse this JSON data, do
//
//     final listOrderResponseModel = listOrderResponseModelFromJson(jsonString);

import 'dart:convert';

class ListOrderResponseModel {
  List<Order>? data;
  Meta? meta;

  ListOrderResponseModel({
    this.data,
    this.meta,
  });

  factory ListOrderResponseModel.fromRawJson(String str) =>
      ListOrderResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      ListOrderResponseModel(
        data: json["data"] == null
            ? []
            : List<Order>.from(json["data"]!.map((x) => Order.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
      };
}

class Order {
  int? id;
  Attributes? attributes;

  Order({
    this.id,
    this.attributes,
  });

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        attributes: json["attributes"] == null
            ? null
            : Attributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes?.toJson(),
      };
}

class Attributes {
  List<Item>? items;
  int? totalPrice;
  String? deliveryAddress;
  String? courierName;
  int? shippingCost;
  String? statusOrder;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? publishedAt;
  int? userId;

  Attributes({
    this.items,
    this.totalPrice,
    this.deliveryAddress,
    this.courierName,
    this.shippingCost,
    this.statusOrder,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.userId,
  });

  factory Attributes.fromRawJson(String str) =>
      Attributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        totalPrice: json["totalPrice"],
        deliveryAddress: json["deliveryAddress"],
        courierName: json["courierName"],
        shippingCost: json["shippingCost"],
        statusOrder: json["statusOrder"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        publishedAt: json["publishedAt"] == null
            ? null
            : DateTime.parse(json["publishedAt"]),
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "totalPrice": totalPrice,
        "deliveryAddress": deliveryAddress,
        "courierName": courierName,
        "shippingCost": shippingCost,
        "statusOrder": statusOrder,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "publishedAt": publishedAt?.toIso8601String(),
        "userId": userId,
      };
}

class Item {
  int? id;
  String? productName;
  int? price;
  int? qty;

  Item({
    this.id,
    this.productName,
    this.price,
    this.qty,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        productName: json["productName"],
        price: json["price"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productName": productName,
        "price": price,
        "qty": qty,
      };
}

class Meta {
  Pagination? pagination;

  Meta({
    this.pagination,
  });

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination?.toJson(),
      };
}

class Pagination {
  int? page;
  int? pageSize;
  int? pageCount;
  int? total;

  Pagination({
    this.page,
    this.pageSize,
    this.pageCount,
    this.total,
  });

  factory Pagination.fromRawJson(String str) =>
      Pagination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json["page"],
        pageSize: json["pageSize"],
        pageCount: json["pageCount"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "pageSize": pageSize,
        "pageCount": pageCount,
        "total": total,
      };
}
