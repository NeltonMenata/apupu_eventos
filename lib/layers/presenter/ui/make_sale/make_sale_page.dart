import 'package:apupu_eventos/layers/data/datasources/back4app/sale/make_sale_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/sale/make_sale/make_sale_repository_imp.dart';
import 'package:apupu_eventos/layers/domain/entities/sale/sale_entity.dart';
import 'package:apupu_eventos/layers/domain/usecases/sale/make_sale/make_sale_usecase_imp.dart';
import 'package:flutter/material.dart';

import 'make_sale_controller.dart';

class MakeSalePage extends StatefulWidget {
  const MakeSalePage({Key? key}) : super(key: key);

  @override
  State<MakeSalePage> createState() => _MakeSalePageState();
}

class _MakeSalePageState extends State<MakeSalePage> {
  final controller = MakeSaleController(
    MakeSaleUseCaseImp(
      MakeSaleRepositoryImp(
        MakeSaleDataSourceBack4appImp(),
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () async {
          final result = await controller.makeSale(SaleEntity(
              products: [],
              eventObjectId: "eventObjectId",
              workerObjectId: "workerObjectId",
              guestObjectId: "guestObjectId"));

          print(result.guestObjectId);
          print(result.error);
        },
        child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(50)),
            child: Text("Vender",
                style: TextStyle(
                    fontSize: width * .05,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))),
      ),
    );
  }
}
