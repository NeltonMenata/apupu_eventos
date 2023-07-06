import 'package:apupu_eventos/layers/data/datasources/back4app/event/confirm_payment_event_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/event/get_event_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/event/confirm_payment_event/confirm_payment_event_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/event/get_event/get_event_repository_imp.dart';
import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/event/get_event/get_event_usecase_imp.dart';
import 'package:apupu_eventos/layers/presenter/ui/admin_panel/admin_panel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../../../domain/usecases/event/confirm_payment_event/confirm_payment_event_usecase_imp.dart';
import '../../utils/utils.dart';

class AdminPanelPage extends StatefulWidget {
  const AdminPanelPage({Key? key}) : super(key: key);

  @override
  State<AdminPanelPage> createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends State<AdminPanelPage> {
  final controller = AdminPanelController(
      ConfirmPaymentEventUseCaseImp(ConfirmPaymentEventRepositoryImp(
          ConfirmPaymentEventDataSourceBack4appImp())),
      GetEventUseCaseImp(
          GetEventRepositoryImp(GetEventDataSourceBack4appImp())));

  final users = [
    {"objectId": "dflj12", "name": "Nelton Menata", "eventNotPayment": 3}
  ];

  bool payment = false;
  bool loadPayment = false;
  bool loadEvent = false;
  EventEntity? currentEvent;

  @override
  Widget build(BuildContext context) {
    // currentEvent = EventEntity(
    //     objectId: "objectId",
    //     name: "name",
    //     dateOfRealization: DateTime.now(),
    //     organization: "organization",
    //     price: 1000,
    //     vip: 25,
    //     priceVip: 2000,
    //     imgCartaz: "",
    //     payment: false,
    //     normal: 24,
    //     productsQuantity: 50,
    //     productsValue: 25000);

    // currentEvent = null;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Painel Administrativo"),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.qr_code_scanner_sharp))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.qr_code_scanner_sharp),
        onPressed: () async {
          final qrCode = await FlutterBarcodeScanner.scanBarcode(
              "red", "Cancelar", true, ScanMode.QR);

          if (qrCode == "-1") {
            return;
          }
          setState(() {
            loadEvent = true;
          });
          final event = await controller.getEvent(context, qrCode);

          setState(() {
            loadEvent = false;
            currentEvent = event;
            payment = currentEvent?.payment ?? false;
          });
        },
      ),
      body: Column(children: [
        /*
        ...users.map((e) {
          final title = e["name"].toString();
          return ListTile(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return Container(
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        height: width,
                        child: Text("Ola Mundo"));
                  });
            },
            leading: CircleAvatar(
              child: Text(
                title[0],
                style: TextStyle(
                    fontSize: width * .055, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(title),
            subtitle: Text("Eventos não pago: ${e["eventNotPayment"]}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.call),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.whatsapp_outlined),
                  onPressed: () {},
                ),
              ],
            ),
          );
       
        })
        */

        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text("Registe os Eventos Pagos",
              style: TextStyle(
                  fontSize: width * .06, fontWeight: FontWeight.bold)),
        ),
        loadEvent
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : currentEvent == null
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                        "Clique no botão QrCode para escanear o Código do Evento.",
                        style: TextStyle(
                            fontSize: width * .05,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold)),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.shade400),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                currentEvent!.name,
                                style: TextStyle(
                                    fontSize: width * .05,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Organização: ${currentEvent!.organization}",
                                style: TextStyle(
                                    fontSize: width * .047,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Convidados Normal: ${currentEvent?.normal}",
                                    style: TextStyle(
                                        fontSize: width * .047,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Convidados Vip: ${currentEvent?.vip}",
                                    style: TextStyle(
                                        fontSize: width * .047,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Ingresso Normal: " +
                                        separatorMoney(
                                            "${currentEvent?.price}") +
                                        " kz",
                                    style: TextStyle(
                                        fontSize: width * .047,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Ingresso Vip: " +
                                        separatorMoney(
                                            "${currentEvent?.priceVip}") +
                                        " kz",
                                    style: TextStyle(
                                        fontSize: width * .047,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Q. Produtos Vendidos: ${currentEvent?.productsQuantity}",
                                    style: TextStyle(
                                        fontSize: width * .047,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "V. Produtos Vendidos: " +
                                        separatorMoney(
                                            "${currentEvent?.priceVip}") +
                                        " kz",
                                    style: TextStyle(
                                        fontSize: width * .047,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            loadPayment
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : payment
                                    ? Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.green.shade600),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            "Pagamento Confirmado",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: width * .047,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )
                                    : ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            loadPayment = !loadPayment;
                                          });
                                          final confirmPayment =
                                              await controller
                                                  .confirmPaymentEvent(
                                                      currentEvent!.objectId);
                                          setState(() {
                                            loadPayment = !loadPayment;
                                            payment = confirmPayment;
                                            if (!confirmPayment) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Ocorreu um erro ao confirmar o pagamento"),
                                                backgroundColor: Colors.red,
                                              ));
                                            }
                                          });
                                        },
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            "Confirmar Pagamento",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: width * .047,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                          ]),
                    ),
                  )
      ]),
    );
  }
}
