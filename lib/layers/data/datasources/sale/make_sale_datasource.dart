import 'package:apupu_eventos/layers/domain/entities/sale/sale_entity.dart';

abstract class IMakeSaleDataSource {
  Future<SaleEntity> call(SaleEntity sale);
}
