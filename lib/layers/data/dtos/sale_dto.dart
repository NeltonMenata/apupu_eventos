// ignore_for_file: annotate_overrides, overridden_fields

import 'dart:convert';
import 'package:apupu_eventos/layers/domain/entities/product/product_entity.dart';
import 'package:apupu_eventos/layers/domain/entities/sale/sale_entity.dart';

class SaleDto extends SaleEntity {
  final String objectId;
  final ProductEntity product;
  final int quantity;
  final String? error;

  SaleDto(this.objectId, this.product, this.quantity, this.error)
      : super(objectId, product, quantity);

  toJson() {
    final map = {
      "objectId": objectId,
      "product": product,
      "quantity": quantity,
      "totalValue": getTotalValueForSale
    };
    return jsonEncode(map);
  }

  factory SaleDto.fromJson(Map<String, dynamic> map) {
    return SaleDto(
        map["objectId"], map["product"], map["quantity"], map["error"]);
  }
}
