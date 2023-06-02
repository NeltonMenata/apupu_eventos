// ignore_for_file: annotate_overrides, overridden_fields

import 'dart:convert';
import '../../domain/entities/product/product_entity.dart';

class ProductDto extends ProductEntity {
  final String name;
  final String? objectId;
  final int price;
  final String eventObjectId;
  final String? error;

  ProductDto(this.objectId, this.name, this.price, this.eventObjectId,
      [this.error])
      : super(objectId, name, price, eventObjectId, error);
  String toJson() {
    final json = {
      "objectId": objectId,
      "name": name,
      "price": price,
      "eventObjectId": eventObjectId
    };

    return jsonEncode(json);
  }

  factory ProductDto.fromJson(Map<String, dynamic> map) {
    return ProductDto(
        map["objectId"], map["name"], map["price"], map["eventObjectId"]);
  }
}
