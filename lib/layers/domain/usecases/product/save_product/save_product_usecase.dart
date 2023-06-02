import 'package:apupu_eventos/layers/domain/entities/product/product_entity.dart';

abstract class ISaveProductUseCase {
  Future<ProductEntity> call(ProductEntity product);
}
