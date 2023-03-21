import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';
import 'package:apupu_eventos/layers/presenter/routes/Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../data/datasources/back4app/get_guest_datasource_back4app_imp.dart';
import '../../../data/datasources/back4app/save_guest_datasource_back4app_imp.dart';
import '../../../data/repositories_imp/get_guest/get_guest_for_objectId_repository_imp.dart';
import '../../../data/repositories_imp/save_guest/save_guest_repository_imp.dart';
import '../../../domain/usecases/guest/get_guest_for_objectId_usecase/get_guest_entity_for_objectId_imp.dart';
import '../../../domain/usecases/guest/save_guest/save_guest_usecase_imp.dart';
import '../../utils/utils.dart';
import '../../utils/widget_to_image.dart';
import '../home_controller.dart';

class RegisterInOrOutGuestPage extends StatefulWidget {
  RegisterInOrOutGuestPage({Key? key}) : super(key: key);

  final controller = HomeController(
      SaveGuestUseCaseImp(
        SaveGuestRepositoryImp(
          SaveGuestDataSourceBack4appImp(),
        ),
      ),
      GetGuestForObjectIdUseCaseImp(
        GetGuestForObjectIdRepositoryImp(
          GetGuestDataSourceBack4appImp(),
        ),
      ));

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

  @override
  Widget build(BuildContext context) {
    final currentEvent =
        ModalRoute.of(context)?.settings.arguments as EventEntity;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    const paddingLeft = 15.0;
    const paddingBottom = 8.0;
    final fontSizeTitle = width * .086;
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
                currentAccountPicture: Image.asset("assets/logo/logo.png"),
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
                          child: QrImage(data: guestCurrent.name),
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
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0,
                                    bottom: 8.0,
                                    left: 4.0,
                                    right: width * .05),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: currentEvent.imgCartaz != null
                                      ? Image.network(currentEvent.imgCartaz!,
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
                                  Text(
                                    guestCurrent.name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: fontSizeSubtitle,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
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
                    ],
                  ),
                );
              },
            ),
            const Spacer(),
            GestureDetector(
              onTapUp: (value) {
                setState(() {
                  guestCurrent.isIn = !guestCurrent.isIn;
                });
              },
              child: guestCurrent.isIn
                  ? Column(
                      children: [
                        Icon(
                          Icons.input_outlined,
                          color: Colors.green,
                          size: width * .15,
                        ),
                        Text(
                          "Convidado está dentro!",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: width * .04),
                        )
                      ],
                    )
                  : Column(
                      children: [
                        Icon(
                          Icons.output_outlined,
                          color: Colors.red,
                          size: width * .15,
                        ),
                        Text(
                          "Convidado está fora!",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: width * .04),
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
                        var qrResult = await FlutterBarcodeScanner.scanBarcode(
                            "red", "Cancelar", true, ScanMode.QR);
                        if (qrResult == "-1") {
                          return;
                        }
                        setState(() {
                          guestCurrent = GuestEntity(
                              contact: "+244",
                              name: qrResult,
                              objectId: "objectId",
                              isIn: true,
                              eventObjectId: "",
                              doormanObjectId: "doormanObjectId");
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
                        final value = await Navigator.of(context)
                            .pushNamed(Routes.ADD_GUEST);

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
