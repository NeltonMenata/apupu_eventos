import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../../worker/remove_worker_event/remove_worker_event_datasource.dart';

class RemoveWorkerEventDataSourceBack4appImp
    implements IRemoveWorkerEventDataSource {
  @override
  Future<bool> call(String workerObjectId, String eventObjectId) async {
    final removeWorker = ParseCloudFunction("removeWorkerEvent");

    try {
      final result = await removeWorker.execute(parameters: {
        "workerObjectId": workerObjectId,
        "eventObjectId": eventObjectId
      });
      return result.result as bool;
    } catch (e) {
      return false;
    }
  }
}
