import 'package:apupu_eventos/layers/domain/entities/report_sale/report_sale_entity.dart';

abstract class IGetAllSaleForEventRepository {
  Future<List<ReportSaleEntity>> call(String eventObjectId);
}
