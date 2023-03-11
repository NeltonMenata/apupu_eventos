import 'package:apupu_eventos/layers/data/datasources/mock/save_guest_datasource_mock_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/save_guest/save_guest_repository_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/save_guest/save_guest_usecase_imp.dart';
import 'package:apupu_eventos/layers/presenter/geral_components/scaffold_general/scaffold_general.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/guest/guest_entity.dart';

class AddGuestPage extends StatefulWidget {
  const AddGuestPage({Key? key}) : super(key: key);

  @override
  State<AddGuestPage> createState() => _AddGuestPageState();
}

class _AddGuestPageState extends State<AddGuestPage> {
  final contactController = TextEditingController();
  final nameController = TextEditingController();
  final saveGuestUseCase = SaveGuestUseCaseImp(
    SaveGuestRepositoryImp(
      SaveGuestDataSourceMockImp(),
    ),
  );
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
                        decoration: _styleTextField(false)),
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
                          color: Colors.white,
                          fontSize: fontSizeTitle,
                          //letterSpacing: 10,
                          letterSpacing: 5,
                          wordSpacing: 3),
                      onChanged: (value) {},
                      maxLength: 9,
                      decoration: _styleTextField(true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (contactController.text.isEmpty ||
                            nameController.text.isEmpty) {
                          showResultCustom(
                              context, "Preencha os campos correctamente!");
                          return;
                        }

                        setState(() {
                          nameController.text;
                          contactController.text;
                        });
                        final guestSaved = await saveGuestUseCase(GuestEntity(
                          contact: contactController.text,
                          name: nameController.text,
                          objectId: "objectId",
                          isIn: false,
                          eventObjectId: "",
                        ));
                        Navigator.of(context).pop(guestSaved);
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

  InputDecoration _styleTextField(bool isPhone) => InputDecoration(
        hintText: "Digite aqui",
        hintStyle: const TextStyle(color: Colors.white, letterSpacing: 0),
        border: const OutlineInputBorder(),
        suffixIcon: Icon(
          isPhone ? Icons.phone_outlined : Icons.person_outline_rounded,
          color: Colors.white,
        ),
      );
}
