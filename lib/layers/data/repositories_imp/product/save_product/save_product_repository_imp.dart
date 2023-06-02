import 'package:apupu_eventos/layers/data/datasources/product/save_product_datasource.dart';
import 'package:apupu_eventos/layers/domain/entities/product/product_entity.dart';
import 'package:apupu_eventos/layers/domain/repositories/product/save_product/save_product_repository.dart';

class SaveProductRepositoryImp implements ISaveProductRepository {
  final ISaveProductDataSource _saveProductDataSource;

  SaveProductRepositoryImp(this._saveProductDataSource);
  @override
  Future<ProductEntity> call(ProductEntity product) async {
    return await _saveProductDataSource(product);
  }
}
