import 'package:apupu_eventos/layers/domain/entities/manager/manager_entity.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../../manager/login_manager/login_manager_datasource.dart';

class LoginManagerDataSourceBack4appImp implements ILoginManagerDataSource {
  @override
  Future<ManagerEntity> call(String username, String password) async {
    //
    try {
      final user = ParseUser(username, password, null);

      final result = await user.login();
      if (result.statusCode == 200 && result.success) {
        return ManagerEntity(
          username: result.results![0].get("username"),
          password: "password",
          name: result.results![0].get("name"),
          isBlocked: result.results![0].get("blocked"),
          isAdmin: result.results![0].get("admin"),
          investor: result.results![0].get("investor"),
          objectId: result.results![0].get("objectId"),
        );
      } else if (result.statusCode == -1) {
        return ManagerEntity(
          username: "username",
          password: "password",
          error: "Erro ao logar, verifique a sua internet!",
          name: "name",
          objectId: "objectId",
        );
      } else {
        return ManagerEntity(
          username: "username",
          password: "password",
          error: "Erro ao logar, verifique os dados de usuário!",
          name: "name",
          objectId: "objectId",
        );
      }
    } catch (e) {
      return ManagerEntity(
        username: "username",
        password: "password",
        error: "Erro ao logar, verifique a sua internet e os dados de usuário!",
        name: "name",
        objectId: "objectId",
      );
    }
  }
}
