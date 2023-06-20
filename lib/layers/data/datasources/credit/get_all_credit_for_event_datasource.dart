import 'package:apupu_eventos/layers/domain/entities/report_credit/report_credit_entity.dart';

abstract class IGetAllCreditForEventDataSource {
  Future<List<ReportCreditEntity>> call(String eventObjectId);
}
