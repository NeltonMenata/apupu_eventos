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
  SearchGuestController get controller => SearchGuestController.controller;
  final List<GuestEntity> listGuest = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? contact = ModalRoute.of(context)?.settings.arguments.toString();
    return Scaffold(
      body: ScaffoldGeneral(
        title: "Resultados da busca",
        subtitle: "Partilhe o Qr Code com o convidado",
        body: FutureBuilder<List<GuestEntity>>(
            future: controller.findGuest(contact.toString()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    ...List.generate(
                      snapshot.data!.length,
                      (index) => Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: QrImage(data: index.toString()),
                            ),
                            title: Text(
                              snapshot.data![index].name,
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              snapshot.data![index].contact,
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: snapshot.data![index].isIn
                                ? IconButton(
                                    icon: Icon(
                                      Icons.input_rounded,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        snapshot.data![index].isIn =
                                            !snapshot.data![index].isIn;
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
                                        snapshot.data![index].isIn =
                                            !snapshot.data![index].isIn;
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
                );
              } else if (snapshot.hasError) {
                return const Text("Erro ao procurar convidado");
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
