import 'package:apupu_eventos/layers/data/datasources/worker/worker_login/worker_login_datasource.dart';
import 'package:apupu_eventos/layers/domain/entities/worker/worker_entity.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class LoginWorkerAdminDataSourceBack4appImp implements IWorkerLoginDataSource {
  @override
  Future<WorkerEntity> call(String username, String password) async {
    //
    try {
      final user = ParseUser(username, password, null);

      final result = await user.login();
      if (result.statusCode == 200 && result.success) {
        if (result.results![0].get("blocked")) {
          return WorkerEntity(
              username: "username",
              password: "password",
              name: "name",
              error: "Usuário blockeado, contacte o administrador!",
              isDoorman: false);
        } else {
          return WorkerEntity(
              username: result.results![0].get("username"),
              password: "password",
              name: result.results![0].get("name"),
              objectId: result.results![0].get("objectId"),
              isDoorman: false);
        }
      } else if (result.statusCode == -1) {
        return WorkerEntity(
            username: "username",
            password: "password",
            error: "Erro ao logar, verifique a sua internet!",
            name: "name",
            objectId: "objectId",
            isDoorman: false);
      } else {
        return WorkerEntity(
            username: "username",
            password: "password",
            error: "Erro ao logar, verifique os dados de usuário!",
            name: "name",
            objectId: "objectId",
            isDoorman: false);
      }
    } catch (e) {
      return WorkerEntity(
          username: "username",
          password: "password",
          error:
              "Erro ao logar, verifique a sua internet e os dados de usuário!",
          name: "name",
          objectId: "objectId",
          isDoorman: false);
    }
  }
}
