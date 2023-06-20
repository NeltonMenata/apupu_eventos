// ignore_for_file: annotate_overrides, overridden_fields

import 'dart:convert';
import 'package:apupu_eventos/layers/domain/entities/product/product_entity.dart';
import 'package:apupu_eventos/layers/domain/entities/sale/sale_entity.dart';

class SaleDto extends SaleEntity {
  final String? objectId;
  final List<ProductEntity> products;
  final String eventObjectId;
  final String? workerObjectId;
  final String guestObjectId;
  final String? error;

  SaleDto(
      {this.objectId,
      required this.products,
      required this.eventObjectId,
      this.workerObjectId,
      required this.guestObjectId,
      this.error})
      : super(
            objectId: objectId,
            products: products,
            eventObjectId: eventObjectId,
            workerObjectId: workerObjectId,
            guestObjectId: guestObjectId,
            error: error);

  toJson() {
    final map = {
      "objectId": objectId,
      "products": products,
      "eventObjectId": eventObjectId,
      "workerObjectId": workerObjectId,
      "guestObjectId": guestObjectId,
      "totalValue": getTotalValueForSale
    };
    return jsonEncode(map);
  }

  factory SaleDto.fromJson(Map<String, dynamic> map) {
    return SaleDto(
        objectId: map["objectId"],
        products: map["products"],
        eventObjectId: map["eventObjectId"],
        workerObjectId: map["workerObjectId"],
        guestObjectId: map["guestObjectId"],
        error: map["error"]);
  }
}
