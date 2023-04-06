import 'package:apupu_eventos/layers/presenter/ui/login/login_controller.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();

  final controller = LoginController();
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
    final fontSizeTitleLabel = width * .040;

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
                    SizedBox(height: height * 0.13),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nome do Usuário",
                      style: TextStyle(
                          fontSize: fontSizeTitleLabel,
                          fontWeight: FontWeight.w900),
                    ),
                    TextField(
                      controller: username,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Nome de Usuário",
                          suffixIcon: Icon(Icons.person_outlined)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Senha do Usuário",
                      style: TextStyle(
                          fontSize: fontSizeTitleLabel,
                          fontWeight: FontWeight.w900),
                    ),
                    TextField(
                      controller: password,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Senha",
                        suffixIcon: Icon(Icons.password_outlined),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 10, right: 10),
                child: isLogin
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        child: const Text("Entrar no Sistema"),
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
                          await widget.controller.login(context,
                              username.text.trim(), password.text.trim());

                          setState(() {
                            isLogin = false;
                          });
                        },
                      ),
              ),
              TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("Logar como Administrador?"),
                    IconButton(
                        onPressed: () {},
                        icon: Checkbox(
                          onChanged: (value) {
                            setState(() {
                              widget.controller.isAdmin =
                                  !widget.controller.isAdmin;
                            });
                          },
                          value: widget.controller.isAdmin,
                        ))
                  ],
                ),
                onPressed: () {
                  setState(() {
                    widget.controller.isAdmin = !widget.controller.isAdmin;
                  });
                },
              ),
            ]),
      ),
    );
  }
}
