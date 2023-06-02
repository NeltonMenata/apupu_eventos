import 'package:apupu_eventos/layers/data/datasources/product/save_product_datasource.dart';
import 'package:apupu_eventos/layers/data/dtos/product_dto.dart';
import 'package:apupu_eventos/layers/domain/entities/product/product_entity.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class SaveProductDataSourceImp implements ISaveProductDataSource {
  @override
  Future<ProductEntity> call(ProductEntity product) async {
    try {
      final saveProduct =
          await ParseCloudFunction("saveProduct").execute(parameters: {
        "name": product.name,
        "price": product.price,
        "eventObjectId": product.eventObjectId
      });

      if (saveProduct.statusCode == 200) {
        if (saveProduct.result["error"] != null) {
          return ProductDto("objectId", "name", 0, saveProduct.result["error"]);
        } else {
          return ProductDto.fromJson(saveProduct.result);
        }
      } else {
        return ProductEntity(
            "objectId", "name", 0, "Verifique a sua conexão com a internet!");
      }
    } catch (e) {
      return ProductEntity("objectId", "name", 0, e.toString());
    }
  }
}
