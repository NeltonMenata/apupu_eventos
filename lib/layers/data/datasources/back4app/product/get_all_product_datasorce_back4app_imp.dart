import 'package:apupu_eventos/layers/data/datasources/product/get_all_product_datasource.dart';
import 'package:apupu_eventos/layers/data/dtos/product_dto.dart';
import 'package:apupu_eventos/layers/domain/entities/product/product_entity.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class GetAllProductDataSourceBack4appImp implements IGetAllProductDataSource {
  @override
  Future<List<ProductEntity>> call(String eventObjectId) async {
    try {
      final getAllProdFun = ParseCloudFunction("getAllProduct");
      final getAllProd = await getAllProdFun
          .execute(parameters: {"eventObjectId": eventObjectId});

      if (getAllProd.statusCode == 200) {
        final List<ProductEntity> allProd = [];
        print(getAllProd.result);
        for (var e in getAllProd.result) {
          allProd.add(
            ProductDto(
                name: e["name"],
                price: e["price"],
                objectId: e["objectId"],
                eventObjectId: eventObjectId),
          );
        }
        return allProd;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
