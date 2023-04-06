import 'package:apupu_eventos/layers/data/datasources/worker/get_all_worker/get_all_worker_datasource.dart';
import 'package:apupu_eventos/layers/domain/entities/worker/worker_entity.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class GetAllWorkerDataSourceBack4appImp implements IGetAllWorkerDataSource {
  @override
  Future<List<WorkerEntity>> call() async {
    final getAllWorker = ParseCloudFunction("getAllWorker");

    final result = await getAllWorker.execute();
    if (result.statusCode == 200) {
      final List<WorkerEntity> list = [];
      result.result.forEach((e) {
        list.add(
          WorkerEntity(
            objectId: e["objectId"],
            name: e["name"],
            username: e["username"],
            password: e["password"],
            isDoorman: e["isDoorman"],
          ),
        );
      });

      return list;
    }
    return [];
  }
}
