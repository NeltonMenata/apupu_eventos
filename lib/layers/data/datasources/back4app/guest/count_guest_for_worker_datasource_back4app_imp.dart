import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../guest/count_guest_for_worker_datasource.dart';

class CountGuestForWorkerDataSourceBack4appImp
    implements ICountGuestForWorkerDataSource {
  @override
  Future<int> call(String workerObjectId, String eventObjectId) async {
    try {
      final countGuestWorker = ParseCloudFunction("countGuestForWorker");

      final result = await countGuestWorker.execute(parameters: {
        "workerObjectId": workerObjectId,
        "eventObjectId": eventObjectId
      });

      return result.result;
    } catch (e) {
      return 0;
    }
  }
}
