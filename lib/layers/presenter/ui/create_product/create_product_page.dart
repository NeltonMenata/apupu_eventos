import 'dart:math';
import 'package:apupu_eventos/layers/core/inject/inject.dart';
import 'package:apupu_eventos/layers/domain/entities/product/product_entity.dart';
import 'package:apupu_eventos/layers/presenter/ui/create_product/create_product_controller.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/event/event_entity.dart';
import '../../utils/utils.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({Key? key}) : super(key: key);

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final controller = getIt<CreateProductController>();
  final priceController = TextEditingController();
  final nameController = TextEditingController();
  //final List<ProductEntity> allProducts = [];
  bool isLoading = false;
  bool complete = true;
  bool isSave = false;
  @override
  Widget build(BuildContext context) {
    final currentEvent =
        ModalRoute.of(context)?.settings.arguments as EventEntity;
    final width = MediaQuery.of(context).size.width;
    const allPadding = 8.0;
    final fontSize = width * .05;
    if (complete) {
      controller.getAllProduct(currentEvent.objectId).then(
        (value) {
          setState(() {
            controller.products.clear();
            controller.products.addAll(value);
            isLoading = false;
            complete = false;
          });
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cria Novos Produtos"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Visibility(
                              visible: controller.products.isEmpty,
                              child: Text(
                                "Nenhum produto foi encontrado, crie um novo!",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .08),
                              ),
                            ),
                            ...controller.products.map((e) {
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
                                        e.name!.toUpperCase(),
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
                      )),
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
                          suffixIcon: Icon(Icons.fastfood_rounded),
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
                      border: OutlineInputBorder(),
                    ),
                  )
                ],
              ),
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
                        final product = await controller.saveProduct(
                            ProductEntity(
                                price: int.parse(
                                  priceController.text,
                                ),
                                eventObjectId: currentEvent.objectId,
                                name:
                                    nameController.text.toLowerCase().trim()));
                        if (product.error != null) {
                          showResultCustom(context, product.error!,
                              isError: true);
                        } else {
                          controller.products.insert(0, product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Produto salvo com sucesso"),
                                shape: RoundedRectangleBorder(),
                                backgroundColor: Colors.green),
                          );
                        }
                        setState(() {
                          nameController.text = "";
                          priceController.text = "";
                          isSave = !isSave;
                        });
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Salvar Produto",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: fontSize),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    isLoading = true;
    super.initState();
  }
}
