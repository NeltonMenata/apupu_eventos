import 'package:apupu_eventos/layers/presenter/routes/Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../data/datasources/back4app/get_guest_datasource_back4app_imp.dart';
import '../../../data/datasources/back4app/save_guest_datasource_back4app_imp.dart';
import '../../../data/repositories_imp/get_guest/get_guest_for_objectId_repository_imp.dart';
import '../../../data/repositories_imp/save_guest/save_guest_repository_imp.dart';
import '../../../domain/entities/guest/guest_entity.dart';
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
  String title = "Registro de Entr/Saida de Convidados";

  GlobalKey key1qrcode = GlobalKey();

  String qrValue = "Name";
  String qrName = "Name";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double fontSize = width * .05;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            /*

            FutureBuilder<GuestEntity>(
              future: widget.controller.getGuest("objectId"),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  return Text(snapshot.data!.name);
                }
                return const Text("Nenhum retorno");
              }),
            ),

            */
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .1,
                left: 10.0,
              ),
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
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
                  height: MediaQuery.of(context).size.width * .7,
                  width: MediaQuery.of(context).size.width * .7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Center(
                          child: QrImage(
                            data: qrValue,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 30,
                        child: Center(
                          child: Text(
                            qrName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          var qrResult =
                              await FlutterBarcodeScanner.scanBarcode(
                                  "red", "Cancelar", true, ScanMode.QR);

                          setState(() {
                            title = qrResult;
                          });
                        },
                        child: const Icon(Icons.qr_code_scanner_outlined),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Utils.capture(key1qrcode, context);
                        },
                        child: const Icon(Icons.share),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          //Utils.capture(key1qrcode, context);

                          /*
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(),
                              context: context,
                              builder: (builder) {
                                return SizedBox(
                                  height: MediaQuery.of(context).size.height * .9,
                                   
                                );
                              });
                          */
                          final value = await Navigator.of(context)
                              .pushNamed(Routes.ADD_GUEST);
                          setState(() {
                            qrName = value.toString();
                            qrValue = value.toString();
                          });
                        },
                        child: const Icon(Icons.group_add),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(Routes.SEARCH_GUEST);
                        },
                        child: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
