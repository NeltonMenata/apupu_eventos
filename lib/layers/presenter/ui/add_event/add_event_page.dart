import 'dart:io';

import 'package:apupu_eventos/layers/presenter/ui/add_event/add_event_controller.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({Key? key}) : super(key: key);

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final controller = AddEventController();
  final dateController = TextEditingController();
  final nameController = TextEditingController();
  final organizationNameController = TextEditingController();
  final priceController = TextEditingController();

  DateTime date = DateTime.now();
  Image image = Image.asset("assets/logo/logo.png");
  File? imageFile;

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
    final circleAvatarSize = width * .2;

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
                "Adicione um Evento novo, com nome e data de realização!",
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
                          "Nome do Evento",
                          style: TextStyle(
                              fontSize: fontSize, fontWeight: FontWeight.w900),
                        ),
                        TextFormField(
                          controller: nameController,
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
                            "Data de Realização",
                            style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.w900),
                          ),
                          TextFormField(
                            controller: dateController,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.event_outlined),
                              border: OutlineInputBorder(),
                            ),
                            onTap: () async {
                              // print(DateTime.now() + 1);
                              date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(
                                        date.year + 1, date.month, date.day),
                                  ) ??
                                  DateTime.now();
                              dateController.text =
                                  "${date.day}/${date.month}/${date.year}";

                              setState(() {});
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(allPadding),
                      child: Column(crossAxisAlignment: crossStart, children: [
                        const Text(
                          "Organização",
                          style: TextStyle(
                              fontSize: fontSize, fontWeight: FontWeight.w900),
                        ),
                        TextFormField(
                          controller: organizationNameController,
                          decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.group_outlined),
                              border: OutlineInputBorder()),
                        )
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(allPadding),
                      child: Column(crossAxisAlignment: crossStart, children: [
                        const Text(
                          "Valor de ingresso",
                          style: TextStyle(
                              fontSize: fontSize, fontWeight: FontWeight.w900),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: priceController,
                          decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.attach_money_outlined),
                              border: OutlineInputBorder()),
                        )
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(allPadding),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black38,
                        ),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(allPadding),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: circleAvatarSize,
                                  width: circleAvatarSize,
                                  child: ClipRRect(
                                    child: image,
                                    borderRadius: BorderRadius.circular(10),
                                    //  radius: circleAvatarSize,
                                  ),
                                ),
                                Column(children: const [
                                  Text(
                                    "Selecione o",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                  ),
                                  Text(
                                    "Cartaz do Evento",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                  ),
                                ]),
                                IconButton(
                                  onPressed: () {
                                    _selectImgCartaz();
                                  },
                                  icon: Icon(
                                    Icons.add_photo_alternate_outlined,
                                    size: width * .1,
                                  ),
                                ),
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
                                      dateController.text.isEmpty ||
                                      organizationNameController.text.isEmpty ||
                                      priceController.text.isEmpty) {
                                    showResultCustom(context,
                                        "Preencha os campos corretamente!");
                                    return;
                                  }

                                  setState(() {
                                    isSave = !isSave;
                                  });
                                  await controller.saveEvent(context,
                                      name: nameController.text,
                                      dateOfRealization: date,
                                      organization:
                                          organizationNameController.text,
                                      price: double.parse(priceController.text),
                                      imgCartaz: imageFile);

                                  setState(() {
                                    nameController.text = "";
                                    dateController.text = "";
                                    organizationNameController.text = "";
                                    priceController.text = "";
                                    isSave = !isSave;
                                  });
                                },
                                child: const Text(
                                  "Salvar Evento",
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

  Future<void> _selectImgCartaz() async {
    final imgCartaz = await ImagePicker.platform.pickImage(
        source: ImageSource.gallery,
        maxHeight: 500,
        maxWidth: 500,
        imageQuality: 50);

    setState(() {
      if (imgCartaz != null) {
        imageFile = File(imgCartaz.path);
        image = Image.file(
          imageFile!,
          fit: BoxFit.cover,
        );
      }
    });
  }
}
