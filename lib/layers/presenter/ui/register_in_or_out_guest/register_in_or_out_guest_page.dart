import 'package:apupu_eventos/layers/core/inject/inject.dart';
import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';
import 'package:apupu_eventos/layers/presenter/routes/Routes.dart';
import 'package:apupu_eventos/layers/presenter/ui/mixins_controllers/done_in_or_out_guest_mixin.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../utils/utils.dart';
import '../../utils/widget_to_image.dart';
import 'register_in_or_out_guest_controller.dart';

class RegisterInOrOutGuestPage extends StatefulWidget {
  RegisterInOrOutGuestPage({Key? key}) : super(key: key);

  final controller = getIt<RegisterInOrOutGuestController>();

  @override
  State<RegisterInOrOutGuestPage> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<RegisterInOrOutGuestPage>
    with DoneInOrOutGuestMixin {
  String title = "Gestão de Convidados";

  GlobalKey key1qrcode = GlobalKey();

  GuestEntity guestCurrent = GuestEntity(
      contact: "contact",
      name: "Nome",
      objectId: "objectId",
      isIn: false,
      eventObjectId: "",
      workerObjectId: "workerId");

  bool isIn = false;
  String statusGuest = "Convidado está fora";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final currentEvent =
        ModalRoute.of(context)?.settings.arguments as EventEntity;

    //final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    //const paddingLeft = 15.0;
    //const paddingBottom = 8.0;
    final fontSizeTitle = width * .086;
    final fontSizeGuest = width * .042;
    final fontSizeSubtitle = width * .049;
    final fontSizeMenu = width * .033;

    return Scaffold(
      drawer: FutureBuilder(
          future: ParseUser.currentUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Visibility(
                visible: snapshot.data != null,
                child: Drawer(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      children: [
                        UserAccountsDrawerHeader(
                          accountName: Text(
                            currentEvent.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          accountEmail: Text(currentEvent.organization),
                          currentAccountPicture: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: currentEvent.imgCartaz != null
                                ? currentEvent.imgCartaz!.isNotEmpty &&
                                        currentEvent.imgCartaz! !=
                                            Utils.assetLogo
                                    ? CachedNetworkImage(
                                        imageUrl: currentEvent.imgCartaz!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(Utils.assetLogo,
                                        fit: BoxFit.cover)
                                : Image.asset(Utils.assetLogo,
                                    fit: BoxFit.cover),
                          ),
                        ),
                        ListTile(
                          title: const Text(
                            "Gerir Trabalhador do Evento",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, Routes.MANAGER_WORKER,
                                arguments: currentEvent);
                          },
                        ),
                        ListTile(
                          title: const Text(
                            "Exibir Relatório do Evento",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, Routes.REPORT_EVENT,
                                arguments: currentEvent);
                          },
                        ),
                        ListTile(
                          title: const Text(
                            "Criar Produtos de Venda no Evento",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                Routes.CREATE_PRODUCT,
                                arguments: currentEvent);
                          },
                        ),
                        ListTile(
                          title: const Text(
                            "Adicionar Crédito",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, Routes.MAKE_CREDIT,
                                arguments: currentEvent);
                          },
                        ),
                        ListTile(
                          title: const Text(
                            "Realizar uma Venda",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, Routes.MAKE_SALE,
                                arguments: currentEvent);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return const SizedBox();
          }),
      appBar: AppBar(
        centerTitle: true,
        title: Text(currentEvent.organization),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .01,
                left: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentEvent.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: fontSizeTitle),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: fontSizeSubtitle),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            WidgetToImage(
              builder: (key) {
                key1qrcode = key;
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  height: MediaQuery.of(context).size.width * .8,
                  width: MediaQuery.of(context).size.width * .7,
                  child: guestCurrent.contact == "contact"
                      ? Center(
                          child: Text(
                            "Clique em Adicionar para criar um Convidado neste Evento.",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: fontSizeSubtitle),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Center(
                                child: QrImage(data: guestCurrent.objectId),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                color: Colors.black45,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: width * .2,
                              child: Center(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.0,
                                            bottom: 8.0,
                                            left: 4.0,
                                            right: width * .03),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: currentEvent.imgCartaz != null
                                              ? currentEvent.imgCartaz!
                                                          .isNotEmpty &&
                                                      currentEvent.imgCartaz! !=
                                                          Utils.assetLogo
                                                  ? CachedNetworkImage(
                                                      imageUrl: currentEvent
                                                          .imgCartaz!,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.asset(Utils.assetLogo,
                                                      fit: BoxFit.cover)
                                              : Image.asset(Utils.assetLogo,
                                                  fit: BoxFit.cover),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 4.0),
                                            child: Text(
                                              guestCurrent.name,
                                              style: TextStyle(
                                                  fontSize: fontSizeGuest,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Text(
                                            "Data: ${currentEvent.dateOfRealization.day}/${currentEvent.dateOfRealization.month}/${currentEvent.dateOfRealization.year}",
                                            style: TextStyle(
                                                fontSize: fontSizeSubtitle * .8,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
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
            const Spacer(),
            GestureDetector(
              onTapUp: (value) async {
                setState(() {
                  isLoading = true;
                });
                isIn = await doneInOrOutGuest(guestCurrent.objectId, !isIn);
                //isIn = await widget.controller
                //  .doneInOrOutGuest(guestCurrent.objectId, !isIn);
                setState(() {
                  isLoading = false;
                  if (isIn) {
                    statusGuest = "Convidado está dentro!";
                  } else {
                    statusGuest = "Convidado está fora!";
                  }
                });
              },
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : isIn
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.input_outlined,
                              color: Colors.green,
                              size: width * .15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                statusGuest,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              ),
                            )
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.output_outlined,
                              color: Colors.red,
                              size: width * .15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                statusGuest,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              ),
                            )
                          ],
                        ),
            ),
            const Spacer(),
            Container(
              color: Colors.grey.shade300,
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        guestCurrent = await widget.controller
                            .getGuest(currentEvent.objectId);

                        if (guestCurrent.contact == "contact") {
                          setState(() {
                            isLoading = false;
                            isIn = false;
                            statusGuest =
                                "Usuário não está cadastrado neste Evento";
                          });
                          showResultCustom(context, "O usuário não existe",
                              isError: true);
                          return;
                        }
                        setState(() {
                          isLoading = false;
                        });
                        isIn = guestCurrent.isIn;
                        if (isIn) {
                          statusGuest =
                              "Acesso Negado, o convidado já está no Evento";
                          showResultCustom(
                              context, "O usuário já está dentro do evento",
                              isError: true);
                        } else {
                          setState(() {
                            isLoading = true;
                          });

                          await doneInOrOutGuest(guestCurrent.objectId, !isIn);
                          setState(() {
                            isLoading = false;
                          });
                          statusGuest = "O Convidado pode entrar no Evento";
                          isIn = !isIn;
                        }
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.qr_code_scanner_outlined,
                            color: Colors.grey.shade700,
                          ),
                          Text(
                            "Registrar\nEntrada",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: fontSizeMenu,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Utils.capture(key1qrcode, context);
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.share_outlined,
                            color: Colors.grey.shade700,
                          ),
                          Text(
                            "Partilhar\nQR Code",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: fontSizeMenu,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final value = await Navigator.of(context).pushNamed(
                            Routes.ADD_GUEST,
                            arguments: currentEvent);

                        if (value != null) {
                          setState(() {
                            guestCurrent = value as GuestEntity;
                            isIn = false;
                            statusGuest = "O Convidado está fora do Evento";
                          });
                        }
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.group_add_outlined,
                            color: Colors.grey.shade700,
                          ),
                          Text(
                            "Adicionar\nConvidado",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: fontSizeMenu,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await Navigator.of(context)
                            .pushNamed(Routes.SEARCH_GUEST,
                                arguments: currentEvent)
                            .then((value) {
                          setState(() {});
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_outlined,
                            color: Colors.grey.shade700,
                          ),
                          Text(
                            "Procurar\nConvidado",
                            style: TextStyle(
                                fontSize: fontSizeMenu,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
