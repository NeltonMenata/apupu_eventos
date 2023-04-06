import 'package:apupu_eventos/layers/presenter/ui/create_worker/create_worker_controller.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/material.dart';

class CreateWorkerPage extends StatefulWidget {
  const CreateWorkerPage({Key? key}) : super(key: key);

  @override
  State<CreateWorkerPage> createState() => _CreateWorkerPageState();
}

class _CreateWorkerPageState extends State<CreateWorkerPage> {
  final controller = CreateWorkerController();
  final usernameController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isDoorman = true;

  bool isSave = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    const paddingLeft = 15.0;
    final paddingTop = height * 0.05;
    const paddingBottom = 15.0;
    const crossStart = CrossAxisAlignment.start;
    const fontSize = 17.0;
    final fontSizeTitle = width * .08;
    const allPadding = 8.0;

    return Scaffold(
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
                left: paddingLeft, top: paddingTop, bottom: paddingBottom),
            child: Column(children: [
              Text(
                "Adicione usuários que hão de trabalhar nos eventos!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: fontSizeTitle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(allPadding),
                      child: Column(crossAxisAlignment: crossStart, children: [
                        const Text(
                          "Nome do Trabalhador",
                          style: TextStyle(
                              fontSize: fontSize, fontWeight: FontWeight.w900),
                        ),
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
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
                          const Text(
                            "Username",
                            style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.w900),
                          ),
                          TextFormField(
                            controller: usernameController,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.event_outlined),
                              border: OutlineInputBorder(),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(allPadding),
                      child: Column(crossAxisAlignment: crossStart, children: [
                        const Text(
                          "Palavra-passe",
                          style: TextStyle(
                              fontSize: fontSize, fontWeight: FontWeight.w900),
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.group_outlined),
                              border: OutlineInputBorder()),
                        )
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(allPadding),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isDoorman = !isDoorman;
                          });
                        },
                        child: Container(
                          width: width * .4,
                          padding: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(children: [
                            const Text(
                              "É porteiro?",
                              style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.w900),
                            ),
                            const Spacer(),
                            Checkbox(
                              value: isDoorman,
                              onChanged: (value) {
                                setState(() {
                                  isDoorman = !isDoorman;
                                });
                              },
                            )
                          ]),
                        ),
                      ),
                    ),
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
                                child: const Text(
                                  "Criar Trabalhador",
                                  style: TextStyle(fontSize: fontSize),
                                ),
                              )),
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
