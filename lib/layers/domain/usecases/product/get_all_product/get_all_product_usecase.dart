import 'package:apupu_eventos/layers/domain/entities/product/product_entity.dart';

abstract class IGetAllProductUseCase {
  Future<List<ProductEntity>> call(String eventObjectId);
}
