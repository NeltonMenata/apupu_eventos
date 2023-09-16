import 'package:apupu_eventos/layers/data/datasources/manager/create_manager/create_manager_datasource.dart';
import 'package:apupu_eventos/layers/domain/entities/manager/manager_entity.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../../manager/create_manager/create_manager_datasource.dart';

class CreateManagerDataSourceBack4appImp implements ICreateManagerDataSource {
  @override
  Future<ManagerEntity> call(ManagerEntity manager) async {
    try {
      // final user = ParseUser.createUser(manager.phone, manager.password, null);
      // user.set("name", manager.name);
      // user.set("phone", manager.phone);
      // user.set("investor", manager.investor);

      // final result = await user.signUp(allowWithoutEmail: true);
      // if (result.success) {
      //   return ManagerEntity(
      //     username: result.results![0].get("username"),
      //     password: "password",
      //     name: result.results![0].get("name"),
      //     objectId: result.results![0].get("objectId"),
      //   );

      final user = ParseCloudFunction("createManager");
      final params = {
        "name": manager.name,
        "username": manager.phone,
        "phone": manager.phone,
        "password": manager.password,
        "uid": manager.uid
      };
      final result = await user.execute(parameters: params);

      if (result.success) {
        return ManagerEntity(username: manager.username, name: manager.name);
      } else if (result.statusCode == -1) {
        return ManagerEntity(
          username: "username",
          password: "password",
          error: "Erro ao criar Conta, verifique a sua internet!",
          name: "name",
          objectId: "objectId",
        );
      } else if (result.error!.message.contains("202")) {
        return ManagerEntity(
          username: "username",
          password: "password",
          error: "Erro ao criar usuário, está conta já existe!",
          name: "name",
          objectId: "objectId",
        );
      } else {
        return ManagerEntity(
          username: "username",
          password: "password",
          error: result.error?.message,
          name: "name",
          objectId: "objectId",
        );
      }
    } catch (e) {
      return ManagerEntity(
        username: "username",
        password: "password",
        error: e.toString(),
        name: "name",
        objectId: "objectId",
      );
    }
  }
}
