import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../routes/Routes.dart';

class LoginController {
  bool isAdmin = false;

  Future<void> login(
      BuildContext context, String username, String password) async {
    username.trim();
    password.trim();
    if (isAdmin) {
      final user = ParseUser(username, password, null);
      try {
        final login = await user.login();
        if (login.success && login.results != null) {
          if (login.results![0].get("blocked")) {
            showResultCustom(
                context, "Usuário bloqueado! \nContacte o apoio técnico",
                isError: true);

            return;
          }
          debugPrint(login.results.toString());
          Navigator.of(context).pushNamed(Routes.HOME);
        } else {
          showResultCustom(
              context, "Dados de usuário incorrectos, tente novamente!");
        }
      } catch (e) {
        showResultCustom(
            context, "Erro ao logar. Verifique a sua conexão com a internet!");
      }
    } else {}
  }
}
