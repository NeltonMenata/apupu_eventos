import 'package:apupu_eventos/layers/data/datasources/worker/verify_worker_event/verify_worker_event_datasource.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class VerifyWorkerEventDataSourceBack4appImp
    implements IVerifyWorkerEventDataSource {
  @override
  Future<bool> call(String workerObjectId, String eventObjectId) async {
    final verifyWorker = ParseCloudFunction("verifyWorkerEvent");

    try {
      final result = await verifyWorker.execute(parameters: {
        "workerObjectId": workerObjectId,
        "eventObjectId": eventObjectId
      });
      return result.result as bool;
    } catch (e) {
      return false;
    }
  }
}
