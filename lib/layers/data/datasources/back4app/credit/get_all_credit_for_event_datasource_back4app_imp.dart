import 'package:apupu_eventos/layers/data/datasources/credit/get_all_credit_for_event_datasource.dart';
import 'package:apupu_eventos/layers/domain/entities/report_credit/report_credit_entity.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class GetAllCreditForEventDataSourceBack4appImp
    implements IGetAllCreditForEventDataSource {
  @override
  Future<List<ReportCreditEntity>> call(String eventObjectId) async {
    final functionGetAllCredit = ParseCloudFunction("getAllCreditForEvent");
    final getAllCredit = await functionGetAllCredit.execute(parameters: {
      "eventObjectId": eventObjectId,
    });

    if (getAllCredit.statusCode == 200) {
      final List<ReportCreditEntity> list = [];
      getAllCredit.result.forEach((e) {
        list.add(
          ReportCreditEntity(e["name"], e["credit"]),
        );
      });
      return list;
    }
    return [ReportCreditEntity("Sem Internet", 0)];
  }
}
