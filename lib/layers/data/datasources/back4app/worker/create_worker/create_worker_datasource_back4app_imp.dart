import 'package:apupu_eventos/layers/data/datasources/worker/create_worker/create_worker_datasource.dart';
import 'package:apupu_eventos/layers/domain/entities/worker/worker_entity.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class CreateWorkerDataSourceBack4appImp implements ICreateWorkerDataSource {
  @override
  Future<WorkerEntity> call(WorkerEntity worker) async {
    final saveWorker = ParseCloudFunction("createWorker");

    try {
      final result = await saveWorker.execute(parameters: {
        "name": worker.name,
        "username": worker.username,
        "password": worker.password,
        "isDoorman": worker.isDoorman,
        "managerObjectId": worker.managerObjectId
      });

      if (result.statusCode == 200 && result.success) {
        if (result.result["error"] != null) {
          return WorkerEntity(
              objectId: "",
              error: result.result["error"],
              name: "",
              username: "username",
              password: "password",
              isDoorman: false);
        } else {
          return WorkerEntity(
            objectId: result.result["objectId"],
            name: result.result["name"],
            username: "",
            password: "",
            isDoorman: result.result["isDoorman"],
          );
        }

        // EventDto.fromMap(saveEvent.results![0]);
      } else {
        return WorkerEntity(
            objectId: "",
            name: "name",
            error: result.error?.message,
            username: "username",
            password: "password",
            isDoorman: false);
      }
    } catch (e) {
      return WorkerEntity(
          objectId: "",
          error: e.toString(),
          name: "name",
          username: "username",
          password: "password",
          isDoorman: false);
    }
  }
}
