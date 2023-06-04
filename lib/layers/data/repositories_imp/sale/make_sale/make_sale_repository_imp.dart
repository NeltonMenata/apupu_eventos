import 'package:apupu_eventos/layers/domain/entities/sale/sale_entity.dart';
import 'package:apupu_eventos/layers/domain/repositories/sale/make_sale/make_sale_repository.dart';

import '../../../datasources/sale/make_sale_datasource.dart';

class MakeSaleRepositoryImp implements IMakeSaleRepository {
  final IMakeSaleDataSource _makeSaleDataSource;
  MakeSaleRepositoryImp(this._makeSaleDataSource);
  @override
  Future<SaleEntity> call(SaleEntity sale) async {
    return await _makeSaleDataSource(sale);
  }
}
