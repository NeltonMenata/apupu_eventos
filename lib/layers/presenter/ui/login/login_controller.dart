import 'package:apupu_eventos/layers/domain/entities/manager/manager_entity.dart';
import 'package:apupu_eventos/layers/domain/entities/worker/worker_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/manager/login_manager/login_manager_usecase.dart';
import 'package:apupu_eventos/layers/domain/usecases/worker/login/login_worker_usecase.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/material.dart';
import '../../routes/Routes.dart';

class LoginController {
  bool isAdmin = false;
  final ILoginManagerUseCase _loginManagerUseCase;
  final ILoginWorkerUseCase _loginWorkerUseCase;

  LoginController(this._loginManagerUseCase, this._loginWorkerUseCase);

  static logout(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.LOGIN, (route) => false);
    currentAdmin = null;
    currentWorker = null;
  }

  Future<void> login(
      BuildContext context, String username, String password) async {
    if (isAdmin) {
      final user = await _loginManagerUseCase(username.trim(), password.trim());
      if (user.error != null) {
        showResultCustom(context, user.error!, isError: true);
      } else {
        currentAdmin = user;
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.MANAGER_EVENT, (route) => false);
      }
    } else {
      final _loginWorker = _loginWorkerUseCase;
      final login = await _loginWorker(username.trim(), password.trim());
      if (login.username == "" && login.password == "") {
        currentWorker = login;
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.MANAGER_EVENT, (route) => false,
            arguments: login.objectId);
      } else {
        showResultCustom(context,
            "Erro ao logar. Verifique a sua conexão com a internet e se os dados do usuário estão correctos!",
            isError: true);
      }
    }
  }
}

WorkerEntity? currentWorker;
ManagerEntity? currentAdmin;
