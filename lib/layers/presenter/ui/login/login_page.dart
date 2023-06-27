import 'package:apupu_eventos/layers/core/inject/inject.dart';
import 'package:apupu_eventos/layers/presenter/ui/login/login_controller.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../routes/Routes.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();

  final controller = getIt<LoginController>();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin = false;

  final username = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    const paddingLeft = 15.0;
    final paddingTop = height * 0.1;
    const paddingBottom = 15.0;
    final fontSizeTitle = width * .086;
    final fontSizeTitleLabel = width * .045;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: paddingLeft, top: paddingTop, bottom: paddingBottom),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                          child: Image.asset(
                        Utils.assetLogo,
                        height: width * 0.2,
                        width: width * 0.2,
                        fit: BoxFit.cover,
                      )),
                    ),
                    Text(
                      "Inicie sua Sessão no Apupu Eventos",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: fontSizeTitle),
                    ),
                    SizedBox(height: height * 0.10),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.controller.isAdmin
                          ? "Telefone"
                          : "Nome de Usuário",
                      style: TextStyle(
                          fontSize: fontSizeTitleLabel,
                          fontWeight: FontWeight.w900),
                    ),
                    TextField(
                      controller: username,
                      keyboardType: widget.controller.isAdmin
                          ? TextInputType.phone
                          : null,
                      decoration: InputDecoration(
                        disabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        border: const OutlineInputBorder(),
                        hintText: widget.controller.isAdmin
                            ? "Telefone"
                            : "Nome de Usuário",
                        suffixIcon: const Icon(Icons.person_outlined),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 12.0, left: 12.0, top: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Senha",
                      style: TextStyle(
                          fontSize: fontSizeTitleLabel,
                          fontWeight: FontWeight.w900),
                    ),
                    TextField(
                      controller: password,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Palavra-passe",
                        suffixIcon: Icon(Icons.password_outlined),
                      ),
                      onSubmitted: (value) {},
                    ),
                  ],
                ),
              ),
              TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("Acessar como Administrador?"),
                    Checkbox(
                      onChanged: (value) async {
                        setState(() {
                          widget.controller.isAdmin =
                              !widget.controller.isAdmin;
                        });
                      },
                      value: widget.controller.isAdmin,
                    )
                  ],
                ),
                onPressed: () {
                  setState(() {
                    widget.controller.isAdmin = !widget.controller.isAdmin;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 6, left: 10, right: 10, bottom: 6),
                child: isLogin
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        child: Text(
                          "Entrar no Sistema",
                          style: TextStyle(fontSize: fontSizeTitleLabel),
                        ),
                        onPressed: () async {
                          if (username.text.isEmpty || password.text.isEmpty) {
                            showResultCustom(
                                context, "Preencha os campos correctamente!",
                                isError: true);
                            return;
                          }
                          setState(() {
                            isLogin = true;
                          });
                          await widget.controller
                              .login(context, username.text, password.text);

                          setState(() {
                            isLogin = false;
                          });
                        },
                      ),
              ),
              const Center(
                  child: Text("OU",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 10, right: 10),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey.shade300)),
                  child: Text(
                    "Criar conta",
                    style: TextStyle(
                        color: Colors.blue, fontSize: fontSizeTitleLabel),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.CREATE_MANAGER);
                  },
                ),
              ),
            ]),
      ),
    );
  }
}
