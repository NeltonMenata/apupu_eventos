import 'package:apupu_eventos/layers/domain/entities/product/product_entity.dart';

abstract class ISaveProductRepository {
  Future<ProductEntity> call(ProductEntity product);
}
