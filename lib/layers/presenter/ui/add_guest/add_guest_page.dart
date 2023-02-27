import 'package:apupu_eventos/layers/presenter/geral_components/scaffold_general/scaffold_general.dart';
import 'package:flutter/material.dart';

class AddGuestPage extends StatefulWidget {
  const AddGuestPage({Key? key}) : super(key: key);

  @override
  State<AddGuestPage> createState() => _AddGuestPageState();
}

class _AddGuestPageState extends State<AddGuestPage> {
  final contactController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double fontSizeTitle = width * .045;
    //double fontSizeSubtitle = width * .035;

    return Scaffold(
      body: SingleChildScrollView(
        child: ScaffoldGeneral(
          title: "Adicione pessoas ao Evento",
          subtitle: "",
          body: SingleChildScrollView(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Nome",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSizeTitle,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: nameController,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: _styleTextField()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Contacto",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSizeTitle,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: contactController,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                          color: Colors.white, fontSize: fontSizeTitle),
                      onChanged: (value) {},
                      maxLength: 9,
                      decoration: _styleTextField(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (contactController.text.isEmpty ||
                            nameController.text.isEmpty) {
                          return;
                        }

                        setState(() {
                          nameController.text;
                          contactController.text;
                        });

                        Navigator.of(context).pop(nameController.text);
                        contactController.text = "";
                        nameController.text = "";
                      },
                      child: const Text("Salvar convidado"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _styleTextField() => const InputDecoration(
        hintText: "Clique aqui para escrever",
        hintStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(),
      );
}
