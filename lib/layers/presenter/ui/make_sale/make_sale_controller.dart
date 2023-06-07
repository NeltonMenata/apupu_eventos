import 'package:apupu_eventos/layers/data/dtos/product_dto.dart';
import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';
import 'package:apupu_eventos/layers/domain/entities/product/product_entity.dart';
import 'package:apupu_eventos/layers/domain/entities/sale/sale_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/sale/make_sale/make_sale_usecase.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../domain/usecases/guest/get_guest_for_objectId_usecase/get_guest_entity_for_objectId.dart';

class MakeSaleController {
  final IMakeSaleUseCase _makeSaleUseCase;
  final IGetGuestForObjectIdUseCase _getGuestForObjectIdUseCase;
  MakeSaleController(this._makeSaleUseCase, this._getGuestForObjectIdUseCase);

  // final List<ProductEntity> products = [
  //   ProductDto.fromJson(
  //     {
  //       "objectId": "WATncvIBnR",
  //       "name": "Cerveja",
  //       "quantity": 3,
  //       "price": 200,
  //       "eventObjectId": "sZMLNUFq6A"
  //     },
  //   ),
  //   ProductDto.fromJson(
  //     {
  //       "objectId": "WATncvIBnR",
  //       "name": "Arroz",
  //       "quantity": 1,
  //       "price": 100,
  //       "eventObjectId": "sZMLNUFq6A"
  //     },
  //   ),
  // ];
  final List<ProductEntity> productsForSale = [];
  Future<GuestEntity> getGuest(String objectId, String eventObjectId) async {
    return await _getGuestForObjectIdUseCase(objectId, eventObjectId);
  }

  Future<SaleEntity> makeSale(BuildContext context, SaleEntity sale) async {
    return await _makeSaleUseCase(sale);
  }
}
