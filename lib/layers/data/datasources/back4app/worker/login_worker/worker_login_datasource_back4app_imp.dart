import 'package:apupu_eventos/layers/data/datasources/worker/worker_login/worker_login_datasource.dart';
import 'package:apupu_eventos/layers/domain/entities/worker/worker_entity.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class WorkerLoginDataSourceBack4appImp implements IWorkerLoginDataSource {
  @override
  Future<WorkerEntity> call(String username, String password) async {
    final loginWorker = ParseCloudFunction("loginWorker");
    try {
      final result = await loginWorker
          .execute(parameters: {"username": username, "password": password});
      if (result.result["error"]) {
        return WorkerEntity(
            username: "username",
            password: "password",
            name: "name",
            objectId: "objectId",
            isDoorman: false);
      }
      return WorkerEntity(
          username: "",
          password: "",
          name: result.result["name"],
          objectId: result.result["objectId"],
          isDoorman: result.result["isDoorman"]);
    } catch (e) {
      return WorkerEntity(
          username: "username",
          password: "password",
          name: "name",
          objectId: "objectId",
          isDoorman: false);
    }
  }
}
