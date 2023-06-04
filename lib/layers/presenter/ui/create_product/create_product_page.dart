import 'dart:math';

import 'package:apupu_eventos/layers/data/datasources/back4app/product/get_all_product_datasorce_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/product/save_product_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/product/get_all_product/get_all_product_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/product/save_product/save_product_repository_imp.dart';
import 'package:apupu_eventos/layers/domain/entities/product/product_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/product/get_all_product/get_all_product_usecase_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/product/save_product/save_product_usecase_imp.dart';
import 'package:apupu_eventos/layers/presenter/ui/create_product/create_product_controller.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({Key? key}) : super(key: key);

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final controller = CreateProductController(
    GetAllProductUseCaseImp(
      GetAllProductRepositoryImp(
        GetAllProductDataSourceBack4appImp(),
      ),
    ),
    SaveProductUseCaseImp(
      SaveProductRepositoryImp(
        SaveProductDataSourceBack4appImp(),
      ),
    ),
  );
  final priceController = TextEditingController();
  final nameController = TextEditingController();
  bool isSave = false;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    const allPadding = 8.0;
    final fontSize = width * .05;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cria Novos Produtos"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<ProductEntity>>(
                  future: controller.getAllProduct("ORj3rqhcN8"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Visibility(
                              visible: snapshot.data!.isEmpty,
                              child: Text(
                                "Nenhum produto foi encontrado, crie um novo!",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .08),
                              ),
                            ),
                            ...snapshot.data!.map((e) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Color.fromRGBO(
                                            Random().nextInt(255),
                                            Random().nextInt(255),
                                            Random().nextInt(255),
                                            .8),
                                        radius: width * .07,
                                        child: Text(
                                          e.name![0].toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: width * .08),
                                        ),
                                      ),
                                      title: Text(
                                        e.name!,
                                        style: TextStyle(
                                            fontSize: width * .05,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Text(e.price.toString() + " kz",
                                          style: TextStyle(
                                              fontSize: width * .05,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    // const Divider(
                                    //   color: Colors.black54,
                                    // )
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
            ),
            const Divider(
              height: 2,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(allPadding),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nome do Produto",
                      style: TextStyle(
                          fontSize: fontSize, fontWeight: FontWeight.w900),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.attach_money_outlined),
                          border: OutlineInputBorder()),
                    )
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.all(allPadding),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Preço do Produto",
                      style: TextStyle(
                          fontSize: fontSize, fontWeight: FontWeight.w900),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: priceController,
                      decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.attach_money_outlined),
                          border: OutlineInputBorder()),
                    )
                  ]),
            ),
            Padding(
                padding: const EdgeInsets.all(allPadding),
                child: isSave
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          if (nameController.text.isEmpty ||
                              priceController.text.isEmpty) {
                            showResultCustom(
                                context, "Preencha os campos corretamente!");
                            return;
                          }

                          setState(() {
                            isSave = !isSave;
                          });
                          final product =
                              await controller.saveProduct(ProductEntity(
                                  price: int.parse(
                                    priceController.text,
                                  ),
                                  eventObjectId: "ORj3rqhcN8",
                                  name: nameController.text));
                          if (product.error != null) {
                            showResultCustom(context, product.error!,
                                isError: true);
                          } else {
                            showResultCustom(
                                context, "Produto salvo com sucesso!");
                          }
                          setState(() {
                            nameController.text = "";
                            priceController.text = "";
                            isSave = !isSave;
                          });
                        },
                        child: Text(
                          "Salvar Produto",
                          style: TextStyle(fontSize: fontSize),
                        ),
                      )),
          ],
        ),
      ),
    );
  }
}
