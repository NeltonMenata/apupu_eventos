import 'package:apupu_eventos/layers/domain/entities/credit/credit_entity.dart';
import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';
import 'package:apupu_eventos/layers/domain/entities/sale/sale_entity.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../../../core/inject/inject.dart';
import '../../../domain/entities/event/event_entity.dart';
import '../login/login_controller.dart';
import 'make_credit_controller.dart';

class MakeCreditPage extends StatefulWidget {
  const MakeCreditPage({Key? key}) : super(key: key);

  @override
  State<MakeCreditPage> createState() => _MakeCreditPageState();
}

class _MakeCreditPageState extends State<MakeCreditPage> {
  bool isLoading = false;

  final controller = getIt<MakeCreditController>();

  @override
  void initState() {
    super.initState();
  }

  GuestEntity? currentGuest;
  SaleEntity? sale;
  bool isCredit = false;
  final creditText = TextEditingController();
  int currentCredit = 0;

  @override
  Widget build(BuildContext context) {
    final workerObjectId = currentWorker?.objectId;
    final width = MediaQuery.of(context).size.width;
    //final height = MediaQuery.of(context).size.height;
    final currentEvent =
        ModalRoute.of(context)?.settings.arguments as EventEntity;

    const allPadding = 8.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Venda de Créditos"),
        actions: [
          isCredit
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: allPadding, horizontal: 12),
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              : ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black54),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      isCredit = true;
                    });
                    if (currentGuest == null) {
                      showResultCustom(
                          context, "Selecione o Convidado do Crédito",
                          isError: true);
                      setState(() {
                        isCredit = false;
                      });
                      return;
                    } else if (currentCredit < 1000) {
                      showResultCustom(
                          context, "Crédito não pode ser inferior a 1.000 kz",
                          isError: true);
                      setState(() {
                        isCredit = false;
                      });
                      return;
                    }
                    final result = await controller.makeCredit(CreditEntity(
                        credit: currentCredit,
                        eventObjectId: currentEvent.objectId,
                        workerObjectId: workerObjectId,
                        guestObjectId: currentGuest?.objectId ?? ""));
                    if (result.error != null) {
                      showResultCustom(context, result.error!, isError: true);
                      setState(() {
                        isCredit = false;
                      });
                      return;
                    }
                    showResultCustom(context,
                        "Credito realizado com sucesso\n\nCrédito atual: ${result.credit} kz",
                        color: Colors.green.shade600);

                    setState(() {
                      currentGuest = null;
                      creditText.clear();
                      currentCredit = 0;
                      isCredit = false;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Carregar",
                          style: TextStyle(
                              fontSize: width * .04,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      const Icon(Icons.money_outlined)
                    ],
                  ),
                ),
        ],
      ),
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  "CRÉDITOS",
                  style: TextStyle(
                      fontSize: width * .05, fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentCredit = 1000;
                  });
                },
                child: Container(
                  width: width * .3,
                  height: width * .3,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.red,
                            Colors.red,
                            Colors.red,
                            Colors.black54
                          ])),
                  child: const FittedBox(
                    child: Text(
                      "1.000 kz",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentCredit = 2000;
                  });
                },
                child: Container(
                  width: width * .3,
                  height: width * .3,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.green,
                            Colors.green,
                            Colors.green,
                            Colors.black54
                          ])),
                  child: const FittedBox(
                    child: Text(
                      "2.000 kz",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentCredit = 5000;
                  });
                },
                child: Container(
                  width: width * .3,
                  height: width * .3,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.grey,
                            Colors.grey,
                            Colors.grey,
                            Colors.black
                          ])),
                  child: const FittedBox(
                    child: Text(
                      "5.000 kz",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
              padding: EdgeInsets.all(width * .06),
              width: double.infinity,
              height: width * .2,
              color: Colors.green.shade900,
              child: FittedBox(
                  child: Row(
                children: [
                  const Text(
                    "Valor à carregar: ",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    separatorMoney(currentCredit.toString()) + " kz",
                    style: const TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ))),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(allPadding),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Valor Personalizado",
                style: TextStyle(
                    fontWeight: FontWeight.w900, fontSize: width * .04),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(allPadding),
            child: TextField(
              controller: creditText,
              onChanged: (value) {
                setState(() {
                  currentCredit = int.tryParse(value) ?? 0;
                });
              },
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: width * .05,
              ),
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          const Spacer(),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(4.0),
        child: currentGuest != null
            ? GestureDetector(
                onTap: () async {
                  final resultScan = await FlutterBarcodeScanner.scanBarcode(
                      "red", "Cancelar", true, ScanMode.QR);
                  if (resultScan == "-1") return;
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Carregando Convidado, aguarde!"),
                  ));
                  final resultGuest = await controller.getGuest(
                      resultScan, currentEvent.objectId);
                  ScaffoldMessenger.of(context).clearSnackBars();
                  if (resultGuest.contact == "contact") {
                    showResultCustom(context, "Usuário não encontrado",
                        isError: true);

                    return;
                  }
                  setState(() {
                    currentGuest = resultGuest;
                  });
                },
                child: Container(
                  width: width * .5,
                  padding: const EdgeInsets.all(allPadding),
                  decoration: BoxDecoration(color: Colors.green.shade600),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.account_circle_outlined,
                        color: Colors.white,
                      ),
                      Flexible(
                          child: FittedBox(
                              child: Text(
                        "${currentGuest?.name}",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: width * .04),
                      ))),
                    ],
                  ),
                ),
              )
            : ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                  ),
                ),
                onPressed: () async {
                  final resultScan = await FlutterBarcodeScanner.scanBarcode(
                      "red", "Cancelar", true, ScanMode.QR);
                  if (resultScan == "-1") return;
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Carregando Convidado, aguarde!"),
                  ));
                  final resultGuest = await controller.getGuest(
                      resultScan, currentEvent.objectId);
                  ScaffoldMessenger.of(context).clearSnackBars();
                  if (resultGuest.contact == "contact") {
                    showResultCustom(context, "Usuário não encontrado",
                        isError: true);
                    return;
                  }
                  setState(() {
                    currentGuest = resultGuest;
                  });
                },
                child: Text(
                  "Convidado",
                  style: TextStyle(
                      fontSize: width * .05,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
      ),
    );
  }
}
