import 'package:apupu_eventos/layers/data/dtos/product_dto.dart';
import 'package:apupu_eventos/layers/domain/entities/product/product_entity.dart';
import 'package:apupu_eventos/layers/domain/entities/sale/sale_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/sale/make_sale/make_sale_usecase.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/material.dart';

class MakeSaleController {
  final IMakeSaleUseCase _makeSaleUseCase;
  MakeSaleController(this._makeSaleUseCase);

  final List<ProductEntity> products = [
    ProductDto.fromJson(
      {
        "objectId": "WATncvIBnR",
        "name": "Cerveja",
        "quantity": 3,
        "price": 200,
        "eventObjectId": "sZMLNUFq6A"
      },
    ),
    ProductDto.fromJson(
      {
        "objectId": "WATncvIBnR",
        "name": "Arroz",
        "quantity": 1,
        "price": 100,
        "eventObjectId": "sZMLNUFq6A"
      },
    ),
  ];
  final List<ProductEntity> productsForSale = [];

  Future<void> makeSale(BuildContext context, SaleEntity sale) async {
    _onConfirmedSale(context, sale);
  }

  _onConfirmedSale(BuildContext context, SaleEntity sale) async {
    final result = await _makeSaleUseCase(sale);
    if (result.error == null) {
      showResultCustom(context, "Compra realizada com sucesso");
    }
  }
}
