import 'package:apupu_eventos/layers/core/inject/inject.dart';
import 'package:apupu_eventos/layers/data/datasources/worker/worker_login/worker_login_datasource.dart';
import 'package:apupu_eventos/layers/domain/entities/worker/worker_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/worker/login/login_worker_usecase.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/material.dart';
import '../../routes/Routes.dart';

class LoginController {
  bool isAdmin = false;
  final IWorkerLoginDataSource _workerLoginAdminDataSource;

  LoginController(this._workerLoginAdminDataSource);

  static logout(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.LOGIN, (route) => false);
    currentAdmin = null;
    currentWorker = null;
  }

  Future<void> login(
      BuildContext context, String username, String password) async {
    if (isAdmin) {
      final user =
          await _workerLoginAdminDataSource(username.trim(), password.trim());
      if (user.error != null) {
        showResultCustom(context, user.error!, isError: true);
      } else {
        currentAdmin = user;
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.HOME, (route) => false);
      }
    } else {
      final _loginWorker = getIt<ILoginWorkerUseCase>();
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

WorkerEntity? currentWorker;
WorkerEntity? currentAdmin;
