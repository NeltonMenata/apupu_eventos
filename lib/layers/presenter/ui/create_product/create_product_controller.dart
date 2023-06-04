import 'package:apupu_eventos/layers/domain/entities/product/product_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/product/get_all_product/get_all_product_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/product/save_product/save_product_usecase.dart';

class CreateProductController {
  final IGetAllProductUseCase _getAllProductUseCase;
  final ISaveProductUseCase _saveProductUseCase;

  CreateProductController(this._getAllProductUseCase, this._saveProductUseCase);

  Future<List<ProductEntity>> getAllProduct(String eventObjectId) async {
    return await _getAllProductUseCase(eventObjectId);
  }

  Future<ProductEntity> saveProduct(ProductEntity product) async {
    return await _saveProductUseCase(product);
  }
}
