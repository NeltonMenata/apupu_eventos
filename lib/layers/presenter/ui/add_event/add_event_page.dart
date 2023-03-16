import 'package:apupu_eventos/layers/presenter/ui/add_event/add_event_controller.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/material.dart';

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

  bool isSave = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    const paddingLeft = 15.0;
    final paddingTop = height * 0.05;
    const paddingBottom = 15.0;
    const crossStart = CrossAxisAlignment.start;
    const fontSize = 17.0;

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
              const Text(
                "Adicione um Evento novo, com nome e data de realização!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
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
                      padding: const EdgeInsets.all(10),
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
                      padding: const EdgeInsets.all(10),
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
                      padding: const EdgeInsets.all(10),
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
                        padding: const EdgeInsets.all(10),
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
                                  await controller.saveEvent(
                                      context,
                                      nameController.text,
                                      date,
                                      organizationNameController.text,
                                      double.parse(priceController.text));

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

  Future<bool> _saveEvent() async {
    await Future.delayed(Duration(seconds: 3));
    return true;
  }
}
