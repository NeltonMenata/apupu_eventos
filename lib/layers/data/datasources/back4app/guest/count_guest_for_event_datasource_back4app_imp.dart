import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../../../domain/entities/report_guest/report_guest_entity.dart';
import '../../guest/count_guest_for_event_datasource.dart';

class CountGuestForEventDataSourceBack4appImp
    implements ICountGuestForEventDataSource {
  @override
  Future<ReportGuestEntity> call(String eventObjectId) async {
    try {
      final countGuestEvent = ParseCloudFunction("countGuestForEvent");

      final reportGeneral = await countGuestEvent
          .execute(parameters: {"eventObjectId": eventObjectId});

      return ReportGuestEntity(
          workerName: "Geral",
          normal: reportGeneral.result["normal"],
          vip: reportGeneral.result["vip"]);
    } catch (e) {
      return ReportGuestEntity(
          error: e.toString(), normal: 0, vip: 0, workerName: "");
    }
  }
}
