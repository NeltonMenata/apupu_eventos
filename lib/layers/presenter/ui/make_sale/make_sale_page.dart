import 'package:apupu_eventos/layers/data/datasources/back4app/sale/make_sale_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/dtos/product_dto.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/sale/make_sale/make_sale_repository_imp.dart';
import 'package:apupu_eventos/layers/domain/entities/sale/sale_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/sale/make_sale/make_sale_usecase_imp.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../core/inject/inject.dart';
import '../../../domain/entities/event/event_entity.dart';
import '../../../domain/entities/product/product_entity.dart';
import '../create_product/create_product_controller.dart';
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
  );
  final List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    isLoading = true;

    controllerProduct.getAllProduct("3OmN4WOlvx").then((value) {
      setState(() {
        isLoading = false;
      });
    });

    super.initState();
  }

  final List<Map<String, dynamic>> productsSelected = [];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final currentEvent =
        ModalRoute.of(context)?.settings.arguments as EventEntity;

    const allPadding = 8.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Vender"),
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
                              "price": e.price
                            })
                        .toList());
                    return Wrap(
                      direction: Axis.horizontal,
                      children: [
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
                                    productsSelected.removeWhere((element) =>
                                        products[index]["objectId"] ==
                                        element["objectId"]);
                                  }
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.grey.shade300),
                                child: Wrap(children: [
                                  Text(
                                    products[index]["name"]!
                                            .toString()
                                            .toUpperCase() +
                                        " " +
                                        products[index]["price"].toString() +
                                        " kz",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
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
                            child: Text(productsSelected[index]["name"]!
                                .toString()
                                .substring(0, 1)
                                .toUpperCase())),
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
                        subtitle: Text("Quant: " +
                            productsSelected[index]["quantity"].toString()),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45)))),
          onPressed: () async {
            final listSale = SaleEntity(
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
                workerObjectId: "9glLL4amYi",
                guestObjectId: "ALNZ1qJxNl");

            showResultCustom(
                context, "Total: ${listSale.getTotalValueForSale}");

            // await controller.makeSale(
            //     context,
            //     SaleEntity(
            //         products: productsSelected
            //             .map(
            //               (e) => ProductDto(
            //                 price: e["price"],
            //                 objectId: e["objectId"],
            //                 eventObjectId: currentEvent.objectId,
            //                 name: e["name"],
            //                 quantity: e["quantity"],
            //               ),
            //             )
            //             .toList(),
            //         eventObjectId: currentEvent.objectId,
            //         workerObjectId: "9glLL4amYi",
            //         guestObjectId: "ALNZ1qJxNl"));
          },
          child: Text("Vender",
              style: TextStyle(
                  fontSize: width * .05,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
      ),
    );
  }
}
