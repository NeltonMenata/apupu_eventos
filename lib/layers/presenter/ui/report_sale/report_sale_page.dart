import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:apupu_eventos/layers/domain/entities/report_sale/report_sale_entity.dart';
import 'package:apupu_eventos/layers/presenter/ui/report_event/report_event_controller.dart';
import 'package:flutter/material.dart';
import '../../../core/inject/inject.dart';
import '../../utils/utils.dart';

class ReportSalePage extends StatelessWidget {
  ReportSalePage({Key? key}) : super(key: key);
  final controller = getIt<ReportEventController>();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final currentEvent =
        ModalRoute.of(context)!.settings.arguments as EventEntity?;
    return Scaffold(
      appBar: AppBar(title: const Text("Relatório de Vendas")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<List<ReportSaleEntity>>(
              future:
                  controller.getAllSaleForEvent(currentEvent?.objectId ?? ""),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  int sumQuant = 0;
                  int sumTotal = 0;
                  snapshot.data?.forEach((e) {
                    sumQuant += e.quantity;
                    sumTotal += e.totalValue;
                  });
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...snapshot.data!.map(
                          (e) => ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                e.name[0].toUpperCase(),
                                style: TextStyle(
                                    fontSize: width * .06,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            title: Text(
                              e.name.toUpperCase(),
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: width * .046,
                                  fontWeight: FontWeight.w800),
                            ),
                            subtitle: Text(
                              "Quantidade: ${e.quantity}",
                              style: TextStyle(
                                  fontSize: width * .045,
                                  fontWeight: FontWeight.w800),
                            ),
                            trailing:
                                Text(separatorMoney("${e.totalValue}") + " kz",
                                    style: TextStyle(
                                      fontSize: width * .046,
                                    )),
                          ),
                        ),
                        Padding(
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
                                      "Total de Vendas",
                                      style: TextStyle(
                                          fontSize: width * .05,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Quantidade: $sumQuant",
                                          style: TextStyle(
                                              fontSize: width * .047,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Valor: " +
                                              separatorMoney("$sumTotal") +
                                              " kz",
                                          style: TextStyle(
                                              fontSize: width * .047,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  )
                                ]),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
