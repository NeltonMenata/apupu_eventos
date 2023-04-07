import 'package:apupu_eventos/layers/data/datasources/worker/get_all_worker_in_event/get_all_worker_in_event_datasource.dart';
import 'package:apupu_eventos/layers/domain/entities/worker/worker_entity_minimal.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class GetAllWorkerInEventDataSourceBack4appImp
    implements IGetAllWorkerInEventDataSource {
  @override
  Future<List<WorkerEntityMinimal>> call(String eventObjectId) async {
    final getAllWorkerInEvent = ParseCloudFunction("getAllWorkerInEvent");

    final result = await getAllWorkerInEvent
        .execute(parameters: {"eventObjectId": eventObjectId});
    if (result.statusCode == 200) {
      final List<WorkerEntityMinimal> list = [];
      result.result.forEach((e) {
        list.add(
          WorkerEntityMinimal(
            objectId: e["objectId"],
            name: e["name"],
          ),
        );
      });

      return list;
    }
    return [];
  }
}
