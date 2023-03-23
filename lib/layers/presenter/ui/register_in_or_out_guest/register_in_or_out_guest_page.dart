import 'package:apupu_eventos/layers/data/datasources/back4app/done_in_or_out_guest_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/done_in_or_out_guest/done_in_or_out_guest_repository_imp.dart';
import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/done_in_or_out_guest/done_in_or_out_guest_imp.dart';
import 'package:apupu_eventos/layers/presenter/routes/Routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../data/datasources/back4app/get_guest_datasource_back4app_imp.dart';
import '../../../data/datasources/back4app/save_guest_datasource_back4app_imp.dart';
import '../../../data/repositories_imp/get_guest/get_guest_for_objectId_repository_imp.dart';
import '../../../data/repositories_imp/save_guest/save_guest_repository_imp.dart';
import '../../../domain/usecases/guest/get_guest_for_objectId_usecase/get_guest_entity_for_objectId_imp.dart';
import '../../../domain/usecases/guest/save_guest/save_guest_usecase_imp.dart';
import '../../utils/utils.dart';
import '../../utils/widget_to_image.dart';
import 'register_in_or_out_guest_controller.dart';

class RegisterInOrOutGuestPage extends StatefulWidget {
  RegisterInOrOutGuestPage({Key? key}) : super(key: key);

  final controller = RegisterInOrOutGuestController(
    SaveGuestUseCaseImp(
      SaveGuestRepositoryImp(
        SaveGuestDataSourceBack4appImp(),
      ),
    ),
    GetGuestForObjectIdUseCaseImp(
      GetGuestForObjectIdRepositoryImp(
        GetGuestDataSourceBack4appImp(),
      ),
    ),
    DoneInOrOutGuestUseCaseImp(
      DoneInOrOutGuestRepositoryImp(
        DoneInOrOutGuestDatasourceBack4appImp(),
      ),
    ),
  );

  @override
  State<RegisterInOrOutGuestPage> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<RegisterInOrOutGuestPage> {
  String title = "Gestão de Convidados";

  GlobalKey key1qrcode = GlobalKey();

  GuestEntity guestCurrent = GuestEntity(
      contact: "+244",
      name: "Nome",
      objectId: "objectId",
      isIn: false,
      eventObjectId: "",
      doormanObjectId: "doormanId");

  bool isIn = false;
  String statusGuest = "Convidado está fora";

  @override
  Widget build(BuildContext context) {
    final currentEvent =
        ModalRoute.of(context)?.settings.arguments as EventEntity;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    const paddingLeft = 15.0;
    const paddingBottom = 8.0;
    final fontSizeTitle = width * .086;
    final fontSizeGuest = width * .045;
    final fontSizeSubtitle = width * .049;
    final fontSizeMenu = width * .033;

    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("Evento"),
                accountEmail: Text("Realização"),
                currentAccountPicture: Image.asset(Utils.assetLogo),
              ),
              ListTile(
                title: Text("Adicionar Porteiros"),
                onTap: () {},
              ),
              ListTile(
                title: Text("Exibir Relatório do Evento"),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .1,
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
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  height: MediaQuery.of(context).size.width * .8,
                  width: MediaQuery.of(context).size.width * .7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Center(
                          child: QrImage(data: guestCurrent.objectId),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.black87,
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
                                    borderRadius: BorderRadius.circular(10),
                                    child: currentEvent.imgCartaz != null
                                        ? currentEvent.imgCartaz!.isNotEmpty
                                            ? CachedNetworkImage(
                                                imageUrl:
                                                    currentEvent.imgCartaz!,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 4.0),
                                      child: Text(
                                        guestCurrent.name,
                                        style: TextStyle(
                                            fontSize: fontSizeGuest,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Text(
                                      "Data: ${currentEvent.dateOfRealization.day}/${currentEvent.dateOfRealization.month}/${currentEvent.dateOfRealization.year}",
                                      style: TextStyle(
                                          fontSize: fontSizeSubtitle * .8,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
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
                isIn = await widget.controller
                    .doneInOrOutGuest(guestCurrent.objectId, !isIn);
                setState(() {
                  if (isIn) {
                    statusGuest = "Convidado está dentro!";
                  } else {
                    statusGuest = "Convidado está fora!";
                  }
                });
              },
              child: isIn
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
                                color: Colors.grey,
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
                                color: Colors.grey,
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
                        guestCurrent = await widget.controller
                            .getGuest(currentEvent.objectId);

                        if (guestCurrent.contact == "contact") {
                          setState(() {
                            statusGuest =
                                "Usuário não está cadastrado neste Evento";
                          });
                          showResultCustom(context, "O usuário não existe",
                              isError: true);
                          return;
                        }

                        isIn = guestCurrent.isIn;
                        if (isIn) {
                          statusGuest =
                              "Acesso Negado, o convidado já está no Evento";
                          showResultCustom(
                              context, "O usuário já está dentro do evento",
                              isError: true);
                        } else {
                          await widget.controller
                              .doneInOrOutGuest(guestCurrent.objectId, !isIn);
                          statusGuest = "O Convidado pode entrar no Evento";
                          isIn = !isIn;
                        }
                        setState(() {
                          /* GuestEntity(
                              contact: "+244",
                              name: "",//qrResult,
                              objectId: "objectId",
                              isIn: true,
                              eventObjectId: "",
                              doormanObjectId: "doormanObjectId");
                              */
                        });
                      },
                      child: Column(
                        children: [
                          const Icon(
                            Icons.qr_code_scanner_outlined,
                            color: Colors.grey,
                          ),
                          Text(
                            "Registrar",
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
                          const Icon(
                            Icons.share_outlined,
                            color: Colors.grey,
                          ),
                          Text(
                            "Compartilhar",
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
                          });
                        }
                      },
                      child: Column(
                        children: [
                          const Icon(
                            Icons.group_add_outlined,
                            color: Colors.grey,
                          ),
                          Text(
                            "Adicionar",
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
                            .pushNamed(Routes.SEARCH_GUEST)
                            .then((value) {
                          setState(() {});
                        });
                      },
                      child: Column(
                        children: [
                          const Icon(
                            Icons.search_outlined,
                            color: Colors.grey,
                          ),
                          Text(
                            "Procurar",
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
