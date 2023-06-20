import 'package:apupu_eventos/layers/data/datasources/sale/get_all_sale_for_event_datasource.dart';
import 'package:apupu_eventos/layers/domain/entities/report_sale/report_sale_entity.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class GetAllSaleForEventDataSourceBack4appImp
    implements IGetAllSaleForEventDataSource {
  @override
  Future<List<ReportSaleEntity>> call(String eventObjectId) async {
    final functionGetAllSale = ParseCloudFunction("getAllSaleForEvent");
    final getAllSale = await functionGetAllSale.execute(parameters: {
      "eventObjectId": eventObjectId,
    });

    if (getAllSale.statusCode == 200) {
      final List<ReportSaleEntity> list = [];
      getAllSale.result.forEach((e) {
        list.add(
          ReportSaleEntity(e["name"], e["quantity"], e["totalValue"]),
        );
      });

      return list;
    }
    return [ReportSaleEntity("Sem Internet", 0, 0)];
  }
}
