import 'package:apupu_eventos/layers/presenter/geral_components/scaffold_general/scaffold_general.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SearchGuestPage extends StatefulWidget {
  const SearchGuestPage({Key? key}) : super(key: key);

  @override
  State<SearchGuestPage> createState() => _SearchGuestPageState();
}

class _SearchGuestPageState extends State<SearchGuestPage> {
  bool _progressIndicator = false;
  List<bool> listGuest = [];

  @override
  void initState() {
    for (var i = 0; i < 30; i++) {
      listGuest.add(false);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ScaffoldGeneral(
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
                        "Contact",
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: listGuest[index]
                          ? IconButton(
                              icon: Icon(
                                Icons.input_rounded,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                setState(() {
                                  listGuest[index] = !listGuest[index];
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
                                  listGuest[index] = !listGuest[index];
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        child: Icon(Icons.search),
        onPressed: () async {
          await showModalBottomSheet(
              shape: const RoundedRectangleBorder(),
              context: context,
              builder: (builder) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Contacto",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              hintText:
                                  "Digite aqui o contacto do convidado...",
                              border: OutlineInputBorder()),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _progressIndicator = !_progressIndicator;
                            });
                          },
                          child: Text("Procurar"),
                        ),
                        Visibility(
                          visible: _progressIndicator,
                          child: LinearProgressIndicator(),
                        )
                      ]),
                );
              });
        },
      ),
    );
  }
}
