import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../../../domain/entities/report_guest/report_guest_entity.dart';
import '../../guest/count_guest_for_worker_datasource.dart';

class CountGuestForWorkerDataSourceBack4appImp
    implements ICountGuestForWorkerDataSource {
  @override
  Future<List<ReportGuestEntity>> call(
      String workerObjectId, String eventObjectId) async {
    try {
      final countGuestWorker = ParseCloudFunction("countGuestForWorker");

      final allGuest = await countGuestWorker.execute(parameters: {
        "workerObjectId": workerObjectId,
        "eventObjectId": eventObjectId
      });
      final List<ReportGuestEntity> list = [];

      allGuest.result.forEach((e) {
        list.add(
          ReportGuestEntity(
            normal: e["normal"],
            vip: e["vip"],
            workerName: e["workerName"],
          ),
        );
      });

      return list;
    } catch (e) {
      return [
        ReportGuestEntity(
            workerName: "", normal: 0, vip: 0, error: e.toString())
      ];
    }
  }
}
