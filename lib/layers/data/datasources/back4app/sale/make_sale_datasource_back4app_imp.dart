import 'package:apupu_eventos/layers/data/datasources/sale/make_sale_datasource.dart';
import 'package:apupu_eventos/layers/data/dtos/product_dto.dart';
import 'package:apupu_eventos/layers/domain/entities/sale/sale_entity.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class MakeSaleDataSourceBack4appImp implements IMakeSaleDataSource {
  @override
  Future<SaleEntity> call(SaleEntity sale) async {
    try {
      //final products = sale.products;
      final products = sale.products
          .map(
            (e) => ProductDto(
                    objectId: e.objectId,
                    name: e.name,
                    price: e.price,
                    eventObjectId: e.eventObjectId,
                    quantity: e.quantity)
                .toMap(),
          )
          .toList();

      print(products);
      final makeSaleFun = ParseCloudFunction("makeSale");

      final makeSale = await makeSaleFun.execute(
        parameters: {
          "guestObjectId": sale.guestObjectId,
          "eventObjectId": sale.eventObjectId,
          "workerObjectId": sale.workerObjectId,
          "products": products,
        },
      );

      if (makeSale.statusCode == 200) {
        if (makeSale.result["error"] != null) {
          return SaleEntity(
              products: [],
              eventObjectId: "eventObjectId",
              workerObjectId: "workerObjectId",
              guestObjectId: "guestObjectId",
              error: makeSale.result["error"]);
        } else {
          return SaleEntity(
            products: [],
            eventObjectId: "eventObjectId",
            workerObjectId: "workerObjectId",
            guestObjectId: makeSale.result["credit"].toString(),
          );
        }
      } else {
        return SaleEntity(
            products: [],
            eventObjectId: "eventObjectId",
            workerObjectId: "workerObjectId",
            guestObjectId: "guestObjectId",
            error: makeSale.statusCode.toString());
      }
    } catch (e) {
      return SaleEntity(
          products: [],
          eventObjectId: "eventObjectId",
          workerObjectId: "workerObjectId",
          guestObjectId: "guestObjectId",
          error: e.toString());
    }
  }
}
