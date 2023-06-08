import 'package:apupu_eventos/layers/data/datasources/back4app/sale/make_sale_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/dtos/product_dto.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/sale/make_sale/make_sale_repository_imp.dart';
import 'package:apupu_eventos/layers/domain/entities/guest/guest_entity.dart';
import 'package:apupu_eventos/layers/domain/entities/sale/sale_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/sale/make_sale/make_sale_usecase_imp.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../../core/inject/inject.dart';
import '../../../domain/entities/event/event_entity.dart';
import '../../../domain/entities/product/product_entity.dart';
import '../../../domain/usecases/guest/get_guest_for_objectId_usecase/get_guest_entity_for_objectId.dart';
import '../create_product/create_product_controller.dart';
import '../login/login_controller.dart';
import 'make_sale_controller.dart';

class MakeSalePage extends StatefulWidget {
  const MakeSalePage({Key? key}) : super(key: key);

  @override
  State<MakeSalePage> createState() => _MakeSalePageState();
}

class _MakeSalePageState extends State<MakeSalePage> {
  final controllerProduct = getIt<CreateProductController>();
  bool isLoading = false;

  final controller = MakeSaleController(
      MakeSaleUseCaseImp(
        MakeSaleRepositoryImp(
          MakeSaleDataSourceBack4appImp(),
        ),
      ),
      getIt<IGetGuestForObjectIdUseCase>());
  final List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
  }

  final List<Map<String, dynamic>> productsSelected = [];

  GuestEntity? currentGuest;
  SaleEntity? sale;
  bool isSale = false;

  @override
  Widget build(BuildContext context) {
    final workerObjectId = LoginController.currentWorker?.objectId;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final currentEvent =
        ModalRoute.of(context)?.settings.arguments as EventEntity;

    const allPadding = 8.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Venda de Produtos"),
        actions: [
          isSale
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
                      isSale = true;
                    });
                    if (currentGuest == null) {
                      showResultCustom(
                          context, "Selecione o Convidado da Compra");
                      setState(() {
                        isSale = false;
                      });
                      return;
                    } else if (productsSelected.isEmpty) {
                      showResultCustom(
                          context, "Selecione os produtos a serem vendidos");
                      setState(() {
                        isSale = false;
                      });
                      return;
                    }
                    final makeSale = await controller.makeSale(context, sale!);
                    if (makeSale.error != null) {
                      showResultCustom(context, makeSale.error!, isError: true);
                      setState(() {
                        isSale = false;
                      });
                      return;
                    }
                    showResultCustom(context, "Venda realizada com sucesso",
                        color: Colors.green.shade600);
                    setState(() {
                      isSale = false;
                      currentGuest = null;
                      sale = null;
                      productsSelected.clear();
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Vender",
                          style: TextStyle(
                              fontSize: width * .04,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      const Icon(Icons.add_shopping_cart_sharp)
                    ],
                  ),
                ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<ProductEntity>>(
                future: controllerProduct.getAllProduct(currentEvent.objectId),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Recarregue a página");
                  } else if (snapshot.hasData) {
                    products.clear();
                    products.addAll(snapshot.data!
                        .map((e) => {
                              "name": e.name,
                              "objectId": e.objectId,
                              "quantity": 1,
                              "price": e.price,
                              "isSelected": false,
                            })
                        .toList());
                    return Wrap(
                      direction: Axis.horizontal,
                      children: [
                        products.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Acesse a tela de criação de produtos para criar um produto vendível!",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * .045),
                                ),
                              )
                            : const SizedBox(),
                        ...List.generate(products.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 12.0, left: 8),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  bool contains = productsSelected.every(
                                      (element) =>
                                          element["objectId"] !=
                                          products[index]["objectId"]);
                                  if (contains) {
                                    productsSelected.add(products[index]);
                                  } else {
                                    productsSelected.removeWhere((element) {
                                      bool resultSelected = products[index]
                                              ["objectId"] ==
                                          element["objectId"];

                                      if (products[index]["objectId"] ==
                                          element["objectId"]) {}
                                      return resultSelected;
                                    });
                                  }

                                  sale = SaleEntity(
                                      products: productsSelected
                                          .map(
                                            (e) => ProductDto(
                                              price: e["price"],
                                              objectId: e["objectId"],
                                              eventObjectId:
                                                  currentEvent.objectId,
                                              name: e["name"],
                                              quantity: e["quantity"],
                                            ),
                                          )
                                          .toList(),
                                      eventObjectId: currentEvent.objectId,
                                      workerObjectId: workerObjectId ?? "admin",
                                      guestObjectId:
                                          currentGuest?.objectId ?? "");
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.grey.shade300),
                                child: Wrap(children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        products[index]["name"]!
                                                .toString()
                                                .toUpperCase() +
                                            ": " +
                                            products[index]["price"]
                                                .toString() +
                                            " kz",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Visibility(
                                        visible: !productsSelected.every(
                                            (element) =>
                                                element["objectId"] !=
                                                products[index]["objectId"]),
                                        child: const Icon(
                                          Icons.check_box_outlined,
                                          color: Colors.blue,
                                        ),
                                      )
                                    ],
                                  ),
                                  // CircleAvatar(
                                  //   child: Text(
                                  //     products[index]["name"]!
                                  //         .toString()
                                  //         .substring(0, 1)
                                  //         .toUpperCase(),
                                  //   ),
                                  // ),
                                ]),
                              ),
                            ),
                          );
                        })
                      ],
                    );
                  } else {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }),
            Column(
              children: [
                const Divider(
                  color: Colors.black87,
                  height: 15,
                  thickness: 3,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    "Lista de Produtos Selecionados",
                    style: TextStyle(
                        fontSize: width * .05, fontWeight: FontWeight.bold),
                  ),
                ),
                ...List.generate(
                  productsSelected.length,
                  (index) => Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            productsSelected[index]["name"]!
                                .toString()
                                .substring(0, 1)
                                .toUpperCase(),
                            style: TextStyle(
                                fontSize: width * .06,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                productsSelected[index]["name"]!
                                    .toString()
                                    .toUpperCase(),
                                maxLines: 1,
                                softWrap: true,
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  child: CircleAvatar(
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    backgroundColor: Colors.green.shade700,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      int? quant =
                                          productsSelected[index]["quantity"];
                                      if (quant != null) {
                                        if (quant >= 1) {
                                          quant++;
                                          productsSelected[index]["quantity"] =
                                              quant;

                                          sale = SaleEntity(
                                              products: productsSelected
                                                  .map(
                                                    (e) => ProductDto(
                                                      price: e["price"],
                                                      objectId: e["objectId"],
                                                      eventObjectId:
                                                          currentEvent.objectId,
                                                      name: e["name"],
                                                      quantity: e["quantity"],
                                                    ),
                                                  )
                                                  .toList(),
                                              eventObjectId:
                                                  currentEvent.objectId,
                                              workerObjectId:
                                                  workerObjectId ?? "admin",
                                              guestObjectId:
                                                  currentGuest?.objectId ?? "");
                                        } else {
                                          return;
                                        }
                                      }
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      int? quant =
                                          productsSelected[index]["quantity"];
                                      if (quant != null) {
                                        if (quant == 1) {
                                          return;
                                        } else {
                                          quant--;
                                          productsSelected[index]["quantity"] =
                                              quant;

                                          sale = SaleEntity(
                                              products: productsSelected
                                                  .map(
                                                    (e) => ProductDto(
                                                      price: e["price"],
                                                      objectId: e["objectId"],
                                                      eventObjectId:
                                                          currentEvent.objectId,
                                                      name: e["name"],
                                                      quantity: e["quantity"],
                                                    ),
                                                  )
                                                  .toList(),
                                              eventObjectId:
                                                  currentEvent.objectId,
                                              workerObjectId:
                                                  workerObjectId ?? "admin",
                                              guestObjectId:
                                                  currentGuest?.objectId ?? "");
                                        }
                                      }
                                    });
                                  },
                                  child: CircleAvatar(
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                    backgroundColor: Colors.red.shade700,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        subtitle: Text(
                            "Quantidade: " +
                                productsSelected[index]["quantity"].toString(),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * .08,
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(border: Border.all()),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Total: ${sale?.getTotalValueForSale ?? 0} kz",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: width * .04),
              ),
              const Spacer(),
              currentGuest != null
                  ? GestureDetector(
                      onTap: () async {
                        final resultScan =
                            await FlutterBarcodeScanner.scanBarcode(
                                "red", "Cancelar", true, ScanMode.QR);
                        if (resultScan == "-1") return;
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
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
                          sale = SaleEntity(
                              products: productsSelected
                                  .map(
                                    (e) => ProductDto(
                                      price: e["price"],
                                      objectId: e["objectId"],
                                      eventObjectId: currentEvent.objectId,
                                      name: e["name"],
                                      quantity: e["quantity"],
                                    ),
                                  )
                                  .toList(),
                              eventObjectId: currentEvent.objectId,
                              workerObjectId: workerObjectId ?? "admin",
                              guestObjectId: currentGuest?.objectId ?? "");
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(allPadding),
                        decoration: BoxDecoration(color: Colors.green.shade600),
                        child: Row(
                          children: [
                            const Icon(Icons.account_circle_outlined),
                            Text("${currentGuest?.name}"),
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
                        final resultScan =
                            await FlutterBarcodeScanner.scanBarcode(
                                "red", "Cancelar", true, ScanMode.QR);
                        if (resultScan == "-1") return;
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
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
                          sale = SaleEntity(
                              products: productsSelected
                                  .map(
                                    (e) => ProductDto(
                                      price: e["price"],
                                      objectId: e["objectId"],
                                      eventObjectId: currentEvent.objectId,
                                      name: e["name"],
                                      quantity: e["quantity"],
                                    ),
                                  )
                                  .toList(),
                              eventObjectId: currentEvent.objectId,
                              workerObjectId: workerObjectId ?? "admin",
                              guestObjectId: currentGuest?.objectId ?? "");
                        });
                      },
                      child: Text("Convidado",
                          style: TextStyle(
                              fontSize: width * .05,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
