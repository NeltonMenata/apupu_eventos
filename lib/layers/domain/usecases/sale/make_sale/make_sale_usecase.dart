import 'package:apupu_eventos/layers/domain/entities/sale/sale_entity.dart';

abstract class IMakeSaleUseCase {
  Future<SaleEntity> call(SaleEntity sale);
}
