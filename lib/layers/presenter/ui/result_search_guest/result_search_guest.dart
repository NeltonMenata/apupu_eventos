import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';
import 'package:apupu_eventos/layers/presenter/geral_components/scaffold_general/scaffold_general.dart';
import 'package:apupu_eventos/layers/presenter/ui/search_guest/search_guest_controller.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ResultSearchGuestPage extends StatefulWidget {
  const ResultSearchGuestPage({Key? key, this.arguments = ""})
      : super(key: key);
  final String arguments;

  @override
  State<ResultSearchGuestPage> createState() => _ResultSearchGuestPageState();
}

class _ResultSearchGuestPageState extends State<ResultSearchGuestPage> {
  late SearchGuestController controller;
  final List<GuestEntity> listGuest = [];

  @override
  void initState() {
    controller = SearchGuestController();
    controller.listGuest.forEach((element) {
      if (element.contact == widget.arguments) {
        print("################################");
        listGuest.add(element);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(ModalRoute.of(context)?.settings.arguments);
    return Scaffold(
      body: ScaffoldGeneral(
        title: "Resultados da busca",
        subtitle: "Partilhe o Qr Code com o convidado",
        body: Column(
          children: [
            ...List.generate(
              listGuest.length,
              (index) => Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: QrImage(data: index.toString()),
                    ),
                    title: Text(
                      "Nome",
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      listGuest[index].contact,
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: listGuest[index].isIn
                        ? IconButton(
                            icon: Icon(
                              Icons.input_rounded,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              setState(() {
                                listGuest[index].isIn = !listGuest[index].isIn;
                              });
                            },
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.output_rounded,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                listGuest[index].isIn = !listGuest[index].isIn;
                              });
                            },
                          ),
                  ),
                  const Divider(
                    color: Colors.white,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
