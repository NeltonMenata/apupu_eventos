import 'package:apupu_eventos/layers/domain/entities/sale/sale_entity.dart';

abstract class IMakeSaleRepository {
  Future<SaleEntity> call(SaleEntity sale);
}
