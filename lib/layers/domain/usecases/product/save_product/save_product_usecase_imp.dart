import 'package:apupu_eventos/layers/domain/entities/product/product_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/product/save_product/save_product_usecase.dart';

import '../../../repositories/product/save_product/save_product_repository.dart';

class SaveProductUseCaseImp implements ISaveProductUseCase {
  final ISaveProductRepository _saveProductRepository;
  SaveProductUseCaseImp(this._saveProductRepository);

  @override
  Future<ProductEntity> call(ProductEntity product) async {
    return await _saveProductRepository(product);
  }
}
