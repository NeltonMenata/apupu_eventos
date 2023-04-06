import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../../worker/add_worker_event/add_worker_event_datasource.dart';

class AddWorkerEventDataSourceBack4appImp implements IAddWorkerEventDataSource {
  @override
  Future<bool> call(String workerObjectId, String eventObjectId) async {
    final addWorker = ParseCloudFunction("addWorkerEvent");

    try {
      final result = await addWorker.execute(parameters: {
        "workerObjectId": workerObjectId,
        "eventObjectId": eventObjectId
      });
      return result.result as bool;
    } catch (e) {
      return false;
    }
  }
}
