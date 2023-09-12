import 'package:apupu_eventos/layers/core/inject/inject.dart';
import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:apupu_eventos/layers/presenter/geral_components/scaffold_general/scaffold_general.dart';
import 'package:apupu_eventos/layers/presenter/ui/mixins_controllers/done_in_or_out_guest_mixin.dart';
import 'package:apupu_eventos/layers/presenter/ui/search_guest/search_guest_controller.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:apupu_eventos/layers/presenter/utils/widget_to_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SearchGuestPage extends StatefulWidget {
  const SearchGuestPage({Key? key}) : super(key: key);

  @override
  State<SearchGuestPage> createState() => _SearchGuestPageState();
}

class _SearchGuestPageState extends State<SearchGuestPage>
    with DoneInOrOutGuestMixin {
  bool isLoading = false;

  GlobalKey key1qrcode = GlobalKey();

  final searchTextController = TextEditingController();
  final controller = getIt<SearchGuestController>();

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
    final width = MediaQuery.of(context).size.width;
    final fontSizeGuest = width * .042;
    final fontSizeSubtitle = width * .049;
    final currentEvent =
        ModalRoute.of(context)?.settings.arguments as EventEntity;
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
                    hintText: "Digite aqui o Contacto",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
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
                  setState(() {
                    isLoading = true;
                  });
                  await controller.findGuest(
                      searchTextController.text, currentEvent.objectId);
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
          subtitle:
              "Encontre os convidados e registe a sua entrada ou saída no evento!",
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
                          leading: GestureDetector(
                            onTap: () async {
                              await showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          WidgetToImage(
                                            builder: (key) {
                                              key1qrcode = key;
                                              return Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    border: Border.all(),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: Colors.white),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .8,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .7,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Expanded(
                                                      child: Center(
                                                        child: QrImage(
                                                            data: controller
                                                                .listGuest[
                                                                    index]
                                                                .objectId),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.black45,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      height: width * .2,
                                                      child: Center(
                                                        child:
                                                            SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                width: width *
                                                                    .155,
                                                                height: width *
                                                                    .155,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  child: currentEvent
                                                                              .imgCartaz !=
                                                                          null
                                                                      ? currentEvent.imgCartaz!.isNotEmpty &&
                                                                              currentEvent.imgCartaz! !=
                                                                                  Utils
                                                                                      .assetLogo
                                                                          ? CachedNetworkImage(
                                                                              imageUrl: currentEvent.imgCartaz!,
                                                                              fit: BoxFit.cover,
                                                                            )
                                                                          : Image.asset(Utils.assetLogo,
                                                                              fit: BoxFit
                                                                                  .cover)
                                                                      : Image.asset(
                                                                          Utils
                                                                              .assetLogo,
                                                                          fit: BoxFit
                                                                              .cover),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child:
                                                                    Visibility(
                                                                  visible: controller
                                                                      .listGuest[
                                                                          index]
                                                                      .isVip,
                                                                  child:
                                                                      const Icon(
                                                                    Icons.star,
                                                                    color: Colors
                                                                        .black,
                                                                    size: 35,
                                                                  ),
                                                                ),
                                                              ),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            4.0),
                                                                    child: Text(
                                                                      controller
                                                                          .listGuest[
                                                                              index]
                                                                          .name,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              fontSizeGuest,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "Data: ${currentEvent.dateOfRealization.day}/${currentEvent.dateOfRealization.month}/${currentEvent.dateOfRealization.year}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            fontSizeSubtitle *
                                                                                .8,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: fontSizeSubtitle),
                                              child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .all(RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15))),
                                                  ),
                                                  onPressed: () {
                                                    Utils.capture(
                                                        key1qrcode,
                                                        context,
                                                        controller
                                                            .listGuest[index]
                                                            .contact,
                                                        true);
                                                  },
                                                  child: const Text(
                                                    "Compartilhar",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )))
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: QrImage(
                                  data: controller.listGuest[index].objectId),
                            ),
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
                              ? GestureDetector(
                                  onTap: () async {
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
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.grey.shade300),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.input_rounded,
                                          color: Colors.green.shade800,
                                        ),
                                        Text(
                                          "Dentro",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green.shade800),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () async {
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
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.grey.shade300),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.output_rounded,
                                          color: Colors.red.shade800,
                                        ),
                                        Text(
                                          "Fora",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red.shade800),
                                        )
                                      ],
                                    ),
                                  ),
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
          setState(() {
            isLoading = true;
          });
          await controller.findGuest(
              searchTextController.text, currentEvent.objectId);
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
