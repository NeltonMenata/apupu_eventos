import 'package:apupu_eventos/layers/data/datasources/worker/get_all_worker/get_all_worker_datasource.dart';
import 'package:apupu_eventos/layers/domain/entities/worker/worker_entity.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class GetAllWorkerDataSourceBack4appImp implements IGetAllWorkerDataSource {
  @override
  Future<List<WorkerEntity>> call([String? managerObjectId]) async {
    final getAllWorker = ParseCloudFunction("getAllWorker");

    try {
      final result = await getAllWorker
          .execute(parameters: {"managerObjectId": managerObjectId});
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
      } else {
        return [
          WorkerEntity(
              username: "username",
              password: "password",
              name: "name",
              isDoorman: false,
              error: result.error?.message)
        ];
      }
    } catch (e) {
      return [
        WorkerEntity(
            username: "username",
            password: "password",
            name: "name",
            isDoorman: false,
            error: e.toString())
      ];
    }
  }
}
