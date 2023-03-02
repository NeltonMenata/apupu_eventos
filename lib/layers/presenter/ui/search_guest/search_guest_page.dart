import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';
import 'package:apupu_eventos/layers/presenter/geral_components/scaffold_general/scaffold_general.dart';
import 'package:apupu_eventos/layers/presenter/routes/Routes.dart';
import 'package:apupu_eventos/layers/presenter/ui/search_guest/search_guest_controller.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SearchGuestPage extends StatefulWidget {
  const SearchGuestPage({Key? key}) : super(key: key);

  @override
  State<SearchGuestPage> createState() => _SearchGuestPageState();
}

class _SearchGuestPageState extends State<SearchGuestPage> {
  bool _progressIndicator = false;
  List<GuestEntity> listGuest = [];
  final searchTextController = TextEditingController();
  late SearchGuestController controller;

  @override
  void initState() {
    controller = SearchGuestController();
    listGuest.addAll(controller.listGuest);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: searchTextController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    hintText: "Procure pelo Contacto",
                    border: InputBorder.none),
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.RESULT_SEARCH_GUEST,
                      arguments: searchTextController.text);
                  searchTextController.text = "";
                },
                icon: const Icon(
                  Icons.search_rounded,
                  color: Colors.black,
                ))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: ScaffoldGeneral(
          paddingTop: 15,
          title: "Procurar convidados",
          subtitle: "Encontre os convidados e registe a sua entrada no evento!",
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
                                  listGuest[index].isIn =
                                      !listGuest[index].isIn;
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
                                  listGuest[index].isIn =
                                      !listGuest[index].isIn;
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
      ),
    );
  }
}
