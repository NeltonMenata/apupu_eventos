// ignore_for_file: annotate_overrides, overridden_fields

import 'dart:convert';
import '../../domain/entities/product/product_entity.dart';

class ProductDto extends ProductEntity {
  final String? name;
  final String? objectId;
  final int price;
  final String eventObjectId;
  final int? quantity;
  final bool? favorite;
  final String? error;

  ProductDto(
      {this.objectId,
      this.name,
      required this.price,
      required this.eventObjectId,
      this.quantity,
      this.favorite,
      this.error})
      : super(
            objectId: objectId,
            name: name,
            price: price,
            eventObjectId: eventObjectId,
            quantity: quantity,
            favorite: favorite,
            error: error);
  String toJson() {
    final json = {
      "objectId": objectId,
      "name": name,
      "price": price,
      "eventObjectId": eventObjectId,
      "quantity": quantity,
      "favorite": favorite,
      "totalValue": totalValue
    };

    return jsonEncode(json);
  }

  Map<String, dynamic> toMap() {
    final json = {
      "objectId": objectId,
      "name": name,
      "price": price,
      "eventObjectId": eventObjectId,
      "quantity": quantity,
      "favorite": favorite,
      "totalValue": totalValue
    };
    return json;
  }

  factory ProductDto.fromJson(Map<dynamic, dynamic> map) {
    return ProductDto(
      objectId: map["objectId"],
      name: map["name"],
      price: map["price"],
      eventObjectId: map["eventObjectId"],
      favorite: map["favorite"],
      quantity: map["quantity"],
    );
  }
}
