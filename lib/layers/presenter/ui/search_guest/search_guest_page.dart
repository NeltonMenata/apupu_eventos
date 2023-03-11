import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';
import 'package:apupu_eventos/layers/presenter/geral_components/scaffold_general/scaffold_general.dart';
import 'package:apupu_eventos/layers/presenter/routes/Routes.dart';
import 'package:apupu_eventos/layers/presenter/ui/search_guest/search_guest_controller.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SearchGuestPage extends StatefulWidget {
  const SearchGuestPage({Key? key}) : super(key: key);

  @override
  State<SearchGuestPage> createState() => _SearchGuestPageState();
}

class _SearchGuestPageState extends State<SearchGuestPage> {
  bool _progressIndicator = false;

  final searchTextController = TextEditingController();
  SearchGuestController get controller => SearchGuestController.controller;

  @override
  void initState() {
    controller.scrollController.addListener(() {
      if (true != false) {}
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.scrollController.removeListener(() {});
    super.dispose();
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
                onPressed: () async {
                  if (searchTextController.text.isEmpty) {
                    showResultCustom(context,
                        "Digite o contacto do convidado que deseja procurar!");
                    return;
                  }
                  Navigator.pushNamed(context, Routes.RESULT_SEARCH_GUEST,
                          arguments: searchTextController.text)
                      .then((value) {
                    setState(() {});
                  });
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
        controller: controller.scrollController,
        child: ScaffoldGeneral(
          paddingTop: 15,
          title: "Procurar convidados",
          subtitle: "Encontre os convidados e registe a sua entrada no evento!",
          //body: Container(),

          body: FutureBuilder<List<GuestEntity>>(
              future: controller.listGuest(),
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
                  return const Text("Erro ao Carregar Convidados");
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.refresh_outlined),
      ),
    );
  }
}
