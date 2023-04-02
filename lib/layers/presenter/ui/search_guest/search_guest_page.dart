import 'package:apupu_eventos/layers/presenter/geral_components/scaffold_general/scaffold_general.dart';
import 'package:apupu_eventos/layers/presenter/ui/mixins_controllers/done_in_or_out_guest_mixin.dart';
import 'package:apupu_eventos/layers/presenter/ui/search_guest/search_guest_controller.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../data/datasources/back4app/guest/search_guest_for_contact_datasource_back4app_imp.dart';
import '../../../data/repositories_imp/guest/search_guest_for_contact/search_guest_for_contact_repository_imp.dart';
import '../../../domain/usecases/guest/search_guest_for_contact/search_guest_entity_for_contact_imp.dart';

class SearchGuestPage extends StatefulWidget {
  const SearchGuestPage({Key? key}) : super(key: key);

  @override
  State<SearchGuestPage> createState() => _SearchGuestPageState();
}

class _SearchGuestPageState extends State<SearchGuestPage>
    with DoneInOrOutGuestMixin {
  bool isLoading = false;

  final searchTextController = TextEditingController();
  final controller = SearchGuestController(SearchGuestForContactUseCaseImp(
      SearchGuestForContactRepositoryImp(
          SearchGuestForContactDataSourceBack4appImp())));

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.cleanListGuest();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eventObjectId = ModalRoute.of(context)?.settings.arguments as String;
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
                  } else if (searchTextController.text.length < 9 ||
                      searchTextController.text.length > 9) {
                    showResultCustom(context,
                        "É obrigatório o campo de procura ter 9 digitos!");
                    return;
                  }
                  /*
                  Navigator.pushNamed(context, Routes.RESULT_SEARCH_GUEST,
                      arguments: {
                        "contact": searchTextController.text,
                        "eventObjectId": eventObjectId
                      }).then((value) {
                    
                  });
                  */
                  setState(() {
                    isLoading = true;
                  });
                  await controller.findGuest(
                      searchTextController.text, eventObjectId);
                  setState(() {
                    isLoading = false;
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
        child: ScaffoldGeneral(
          paddingTop: 15,
          title: "Procurar convidados",
          subtitle: "Encontre os convidados e registe a sua entrada no evento!",
          //body: Container(),

          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: List.generate(
                    controller.listGuest.length,
                    (index) => Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: QrImage(data: index.toString()),
                          ),
                          title: Text(
                            controller.listGuest[index].name,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            controller.listGuest[index].contact,
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: controller.listGuest[index].isIn
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.input_rounded,
                                    color: Colors.green,
                                  ),
                                  onPressed: () async {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.red.shade900,
                                      content: Text(
                                          "Registrando saída do Convidado(a): ${controller.listGuest[index].name}"),
                                    ));
                                    controller.listGuest[index].isIn =
                                        await doneInOrOutGuest(
                                            controller
                                                .listGuest[index].objectId,
                                            !controller.listGuest[index].isIn);
                                    setState(() {});
                                  },
                                )
                              : IconButton(
                                  icon: const Icon(
                                    Icons.output_rounded,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.green.shade900,
                                      content: Text(
                                          "Registrando entrada do Convidado(a): ${controller.listGuest[index].name}"),
                                    ));
                                    controller.listGuest[index].isIn =
                                        await doneInOrOutGuest(
                                            controller
                                                .listGuest[index].objectId,
                                            !controller.listGuest[index].isIn);

                                    setState(() {});
                                  },
                                ),
                        ),
                        const Divider(
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (searchTextController.text.isEmpty) {
            showResultCustom(
                context, "Digite o contacto do convidado que deseja procurar!");
            return;
          } else if (searchTextController.text.length < 9 ||
              searchTextController.text.length > 9) {
            showResultCustom(
                context, "É obrigatório o campo de procura ter 9 digitos!");
            return;
          }
          /*
                  Navigator.pushNamed(context, Routes.RESULT_SEARCH_GUEST,
                      arguments: {
                        "contact": searchTextController.text,
                        "eventObjectId": eventObjectId
                      }).then((value) {
                    
                  });
                  */
          setState(() {
            isLoading = true;
          });
          await controller.findGuest(searchTextController.text, eventObjectId);
          setState(() {
            isLoading = false;
          });
          searchTextController.text = "";
        },
        child: const Icon(Icons.search_rounded),
      ),
    );
  }
}
