import 'package:apupu_eventos/layers/core/inject/inject.dart';
import 'package:apupu_eventos/layers/presenter/ui/create_worker/create_worker_controller.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/material.dart';

class CreateWorkerPage extends StatefulWidget {
  const CreateWorkerPage({Key? key}) : super(key: key);

  @override
  State<CreateWorkerPage> createState() => _CreateWorkerPageState();
}

class _CreateWorkerPageState extends State<CreateWorkerPage> {
  final controller = getIt<CreateWorkerController>();
  final usernameController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isDoorman = true;

  bool isSave = false;

  @override
  Widget build(BuildContext context) {
    //final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    const paddingLeft = 15.0;
    const paddingTop = 16.0;
    const paddingBottom = 15.0;
    const crossStart = CrossAxisAlignment.start;
    final fontSize = width * .045;
    final fontSizeTitle = width * .05;
    const allPadding = 8.0;

    return Scaffold(
      /*
      appBar: AppBar(
        title: const Text(
          "Trabalhador",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      */
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
                left: paddingLeft, top: paddingTop, bottom: paddingBottom),
            child: Column(children: [
              Text(
                "Adicione usuários que hão de trabalhar nos eventos!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Arial Black",
                  fontSize: fontSizeTitle * 1.35,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(allPadding),
                      child: Column(crossAxisAlignment: crossStart, children: [
                        Text(
                          "Nome do Trabalhador",
                          style: TextStyle(
                              fontSize: fontSize, fontWeight: FontWeight.w900),
                        ),
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                              hintText: "Nome",
                              suffixIcon:
                                  Icon(Icons.insert_drive_file_outlined),
                              border: OutlineInputBorder()),
                        )
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(allPadding),
                      child: Column(
                        crossAxisAlignment: crossStart,
                        children: [
                          Text(
                            "Username",
                            style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.w900),
                          ),
                          TextFormField(
                            controller: usernameController,
                            decoration: const InputDecoration(
                              hintText: "Username",
                              suffixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(allPadding),
                      child: Column(crossAxisAlignment: crossStart, children: [
                        Text(
                          "Palavra-passe",
                          style: TextStyle(
                              fontSize: fontSize, fontWeight: FontWeight.w900),
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                              hintText: "Senha",
                              suffixIcon: Icon(Icons.password_outlined),
                              border: OutlineInputBorder()),
                        )
                      ]),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                        padding: const EdgeInsets.all(allPadding),
                        child: isSave
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ElevatedButton(
                                onPressed: () async {
                                  if (nameController.text.isEmpty ||
                                      usernameController.text.isEmpty ||
                                      passwordController.text.isEmpty) {
                                    showResultCustom(context,
                                        "Preencha os campos corretamente!");
                                    return;
                                  }

                                  setState(() {
                                    isSave = !isSave;
                                  });
                                  await controller.createWorker(context,
                                      name: nameController.text,
                                      username: usernameController.text,
                                      password: passwordController.text,
                                      isDoorman: isDoorman);

                                  setState(() {
                                    nameController.text = "";
                                    usernameController.text = "";
                                    passwordController.text = "";

                                    isSave = !isSave;
                                  });
                                },
                                child: Text(
                                  "Criar Trabalhador",
                                  style: TextStyle(fontSize: fontSize),
                                ),
                              )),
                    // SizedBox(
                    //   height: width * .07,
                    // ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
