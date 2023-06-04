import 'package:apupu_eventos/layers/data/dtos/product_dto.dart';
import 'package:apupu_eventos/layers/domain/entities/product/product_entity.dart';
import 'package:apupu_eventos/layers/domain/entities/sale/sale_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/sale/make_sale/make_sale_usecase.dart';

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

  Future<SaleEntity> makeSale(SaleEntity sale) async {
    SaleEntity saleEntity = SaleEntity(
        products: products,
        // products: [
        //   ProductDto(
        //     price: 200,
        //     eventObjectId: "sZMLNUFq6A",
        //     name: "Nocal",
        //     objectId: "YwDAKRbNyO",
        //     quantity: 4,
        //   )
        // ],
        eventObjectId: "sZMLNUFq6A",
        workerObjectId: "9glLL4amYi",
        guestObjectId: "ALNZ1qJxNl");
    return await _makeSaleUseCase(saleEntity);
  }
}
