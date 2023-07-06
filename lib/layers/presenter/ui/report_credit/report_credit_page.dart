import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:apupu_eventos/layers/presenter/ui/report_event/report_event_controller.dart';
import 'package:flutter/material.dart';
import '../../../core/inject/inject.dart';
import '../../../domain/entities/report_credit/report_credit_entity.dart';
import '../../utils/utils.dart';

class ReportCreditPage extends StatelessWidget {
  ReportCreditPage({Key? key}) : super(key: key);
  final controller = getIt<ReportEventController>();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final currentEvent =
        ModalRoute.of(context)!.settings.arguments as EventEntity?;
    return Scaffold(
      appBar: AppBar(title: const Text("Relatório de Cartão de Consumo")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: FutureBuilder<List<ReportCreditEntity>>(
            future:
                controller.getAllCreditForEvent(currentEvent?.objectId ?? ""),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                int sumCredit = 0;

                snapshot.data?.forEach((e) {
                  sumCredit += e.credit;
                });
                return Column(
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
                          style: TextStyle(
                              fontSize: width * .05,
                              fontWeight: FontWeight.w500),
                          //maxLines: 1,
                        ),
                        trailing: Text(
                          separatorMoney("${e.credit}") + " kz",
                          style: TextStyle(
                              fontSize: width * .05,
                              fontWeight: FontWeight.w800),
                        ),
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
                                  "Total de Créditos",
                                  style: TextStyle(
                                      fontSize: width * .05,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Valor: " +
                                          separatorMoney("$sumCredit") +
                                          " kz",
                                      style: TextStyle(
                                          fontSize: width * .048,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              )
                            ]),
                      ),
                    )
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
