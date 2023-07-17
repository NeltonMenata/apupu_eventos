import 'package:apupu_eventos/layers/core/inject/inject.dart';
import 'package:apupu_eventos/layers/domain/entities/manager/manager_entity.dart';
import 'package:flutter/material.dart';
import '../../utils/utils.dart';
import 'create_manager_controller.dart';

class CreateManagerPage extends StatefulWidget {
  const CreateManagerPage({Key? key}) : super(key: key);

  @override
  State<CreateManagerPage> createState() => _CreateManagerPageState();
}

class _CreateManagerPageState extends State<CreateManagerPage> {
  final controller = getIt<CreateManagerController>();

  bool isCreate = false;

  final nameController = TextEditingController();
  final usernameController = TextEditingController(text: "username");
  final passwordController = TextEditingController();
  final passwordAgainController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final paddingHorizontal = width * .04;
    final paddingTop = height * .07;
    final paddingBottom = height * .04;
    final fontSizeTitle = width * .07;
    final fontSizeTitleLabel = width * .045;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: paddingHorizontal,
                    top: paddingTop,
                    bottom: paddingBottom),
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
                      "Crie a sua Conta no Apupu Eventos e Gerencie seus Eventos",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: fontSizeTitle),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nome",
                      style: TextStyle(
                          fontSize: fontSizeTitleLabel,
                          fontWeight: FontWeight.w900),
                    ),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        border: OutlineInputBorder(),
                        hintText: "Nome",
                        suffixIcon: Icon(Icons.person_outlined),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 8.0,
                  right: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Telefone",
                      style: TextStyle(
                          fontSize: fontSizeTitleLabel,
                          fontWeight: FontWeight.w900),
                    ),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      maxLength: 9,
                      style: TextStyle(
                        letterSpacing: 4,
                        fontSize: fontSizeTitleLabel - 2,
                      ),
                      decoration: const InputDecoration(
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        border: OutlineInputBorder(),
                        hintText: "Número telefónico",
                        suffixIcon: Icon(Icons.phone_android),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 8.0, left: 8.0, top: 8.0, bottom: 8),
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
                      controller: passwordController,
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
              Padding(
                padding: const EdgeInsets.only(
                    right: 8.0, left: 8.0, top: 8.0, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Confirme a Senha",
                      style: TextStyle(
                          fontSize: fontSizeTitleLabel,
                          fontWeight: FontWeight.w900),
                    ),
                    TextField(
                      controller: passwordAgainController,
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
              Padding(
                padding: const EdgeInsets.only(
                  top: 6,
                  left: 10,
                  right: 10,
                ),
                child: isCreate
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        child: Text("Salvar conta",
                            style: TextStyle(fontSize: fontSizeTitleLabel)),
                        onPressed: () async {
                          if (phoneController.text.isEmpty ||
                              nameController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            showResultCustom(
                                context, "Preencha os campos correctamente!",
                                isError: true);
                            return;
                          }
                          if (phoneController.text.length < 9) {
                            showResultCustom(context,
                                "Número telefónico deve ter 9 dígitos!",
                                isError: true);
                            return;
                          }
                          if (passwordController.text.length < 5) {
                            showResultCustom(context,
                                "Palavra-passe deve ter mais de 5 caracteres!",
                                isError: true);
                            return;
                          }
                          if (passwordController.text !=
                              passwordAgainController.text) {
                            showResultCustom(
                                context, "As senhas devem ser iguais!",
                                isError: true);
                            return;
                          }
                          setState(() {
                            isCreate = true;
                          });
                          final user = await controller.createManager(
                            ManagerEntity(
                                username: usernameController.text.trim(),
                                name: nameController.text.trim(),
                                phone: phoneController.text.trim(),
                                investor: "original",
                                password: passwordController.text.trim()),
                          );
                          if (user.error != null) {
                            showResultCustom(context, user.error!,
                                isError: true);
                            setState(() {
                              isCreate = false;
                            });
                            return;
                          }

                          final name = nameController.text;
                          final username = phoneController.text;
                          final password = passwordController.text;
                          showResultCustom(
                            context,
                            "Conta criada com sucesso, clique em OK para Entrar no Sistema!",
                            action: () {
                              Navigator.pop(
                                context,
                                ManagerEntity(
                                  username: username,
                                  name: name,
                                  password: password,
                                ),
                              );
                            },
                            color: Colors.green.shade700,
                          );
                          setState(() {
                            nameController.clear();
                            phoneController.clear();
                            passwordController.clear();
                            passwordAgainController.clear();
                            isCreate = false;
                          });
                        },
                      ),
              ),
              TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text("Voltar para tela de Login?"),
                  ],
                ),
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
              ),
            ]),
      ),
    );
  }
}
