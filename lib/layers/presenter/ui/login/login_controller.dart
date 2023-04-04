import 'package:apupu_eventos/layers/data/datasources/back4app/worker/login_worker/worker_login_datasource_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/worker/worker_login/worker_login_repository_imp.dart';
import 'package:apupu_eventos/layers/domain/entities/worker/worker_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/worker/login/login_worker_usecase_imp.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../routes/Routes.dart';

class LoginController {
  bool isAdmin = false;
  static WorkerEntity? currentWorker;
  static logout(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.LOGIN, (route) => false);
    currentWorker = null;
  }

  Future<void> login(
      BuildContext context, String username, String password) async {
    username.trim();
    password.trim();
    if (isAdmin) {
      final user = ParseUser(username, password, null);
      try {
        final login = await user.login();
        if (login.statusCode == 200 && login.success) {
          if (login.results![0].get("blocked")) {
            showResultCustom(
                context, "Usuário bloqueado! \nContacte o apoio técnico",
                isError: true);

            return;
          }

          Navigator.of(context)
              .pushNamedAndRemoveUntil(Routes.HOME, (route) => false);
        } else {
          if (login.statusCode == -1) {
            showResultCustom(context,
                "Erro ao Logar, verifique a sua conexão com a Internet!");
          } else {
            showResultCustom(
                context, "Dados de usuário incorrectos, tente novamente!");
          }
        }
      } catch (e) {
        showResultCustom(
            context, "Erro ao logar. Verifique a sua conexão com a internet!");
      }
    } else {
      final _loginWorker = LoginWorkerUseCaseImp(
        WorkerLoginRepositoryImp(
          WorkerLoginDataSourceImp(),
        ),
      );
      final login = await _loginWorker(username, password);
      if (login.username == "" && login.password == "") {
        currentWorker = login;
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.MANAGER_EVENT, (route) => false,
            arguments: login.objectId);
      } else {
        showResultCustom(context,
            "Erro ao logar. Verifique a sua conexão com a internet e se os dados do usuário estão correctos!");
      }
    }
  }
}
