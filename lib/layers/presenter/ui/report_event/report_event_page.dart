import 'package:apupu_eventos/layers/data/datasources/back4app/guest/count_guest_for_event_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/guest/count_guest_for_worker_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/datasources/back4app/worker/get_all_worker_in_event/get_all_worker_in_event_datasource_back4app_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/guest/count_guest_for_event/count_guest_for_event_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/guest/count_guest_for_worker/count_guest_for_worker_repository_imp.dart';
import 'package:apupu_eventos/layers/data/repositories_imp/worker/get_all_worker_in_event/get_all_worker_in_event_imp.dart';
import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:apupu_eventos/layers/domain/entities/worker/worker_entity_minimal.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/count_guest_for_event/count_guest_for_event_usecase_imp.dart';
import 'package:apupu_eventos/layers/domain/usecases/guest/count_guest_for_worker/count_guest_for_worker_usecase_imp.dart';
import 'package:apupu_eventos/layers/presenter/ui/report_event/report_event_controller.dart';
import 'package:flutter/material.dart';
import '../../../domain/usecases/worker/get_all_worker_in_event/get_all_worker_in_event_usecase_imp.dart';

class ReportEventPage extends StatefulWidget {
  ReportEventPage({Key? key}) : super(key: key);

  final controller = ReportEventController(
    GetAllWorkerInEventUseCaseImp(
      GetAllWorkerInEventRepositoryImp(
        GetAllWorkerInEventDataSourceBack4appImp(),
      ),
    ),
    CountGuestForEventUseCaseImp(
      CountGuestForEventRepositoryImp(
        CountGuestForEventDataSourceBack4appImp(),
      ),
    ),
    CountGuestForWorkerUseCaseImp(
      CountGuestForWorkerRepositoryImp(
        CountGuestForWorkerDataSourceBack4appImp(),
      ),
    ),
  );

  @override
  State<ReportEventPage> createState() => _ReportEventPageState();
}

class _ReportEventPageState extends State<ReportEventPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    const paddingLeft = 15.0;
    final paddingTop = height * 0.1;
    const paddingBottom = 15.0;
    final fontSizeTitle = width * .085;
    final fontSizeSubtitle = width * .044;
    final allPadding = width * .04;

    final currentEvent =
        ModalRoute.of(context)!.settings.arguments as EventEntity;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: allPadding, left: allPadding),
                height: height * .2,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.orange),
                child: Text(
                  "Relatório do Evento ${currentEvent.name}",
                  style: TextStyle(
                      fontSize: fontSizeTitle, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: FutureBuilder<List<WorkerEntityMinimal>>(
                    future: widget.controller
                        .getAllWorkerInEvent(currentEvent.objectId),
                    builder: (context, snapshotWorker) {
                      if (snapshotWorker.hasError) {
                        return const Center(
                          child: Text("Erro ao Carregar dados!"),
                        );
                      } else if (snapshotWorker.hasData) {
                        return Column(children: [
                          ...List.generate(snapshotWorker.data!.length,
                              (index) {
                            return FutureBuilder<int>(
                              future: widget.controller.countGuestWorker(
                                  snapshotWorker.data![index].objectId,
                                  currentEvent.objectId),
                              builder: (context, snapshotCount) {
                                if (snapshotCount.hasError) {
                                  return const Center(
                                    child: Text("Erro ao carregar dados!"),
                                  );
                                } else if (snapshotCount.hasData) {
                                  final totalMoney =
                                      currentEvent.price * snapshotCount.data!;
                                  return Column(
                                    children: [
                                      Container(
                                        height: width * .5,
                                        width: width * .9,
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.blue,
                                        ),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                snapshotWorker
                                                    .data![index].name,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: fontSizeSubtitle),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Convidados: ",
                                                    style: TextStyle(
                                                        fontSize:
                                                            fontSizeTitle * .8,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "${snapshotCount.data!}",
                                                    style: TextStyle(
                                                        fontSize: fontSizeTitle,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  const Text("Ingresso:",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(
                                                      currentEvent.price
                                                              .toStringAsFixed(
                                                                  0) +
                                                          " kz",
                                                      style: const TextStyle(
                                                          color: Colors.white)),
                                                ],
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  const Text("Total:",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(
                                                      totalMoney
                                                              .toStringAsFixed(
                                                                  0) +
                                                          " kz",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const Divider()
                                    ],
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            );
                          }),
                          FutureBuilder<int>(
                              future: widget.controller
                                  .countGuestEvent(currentEvent.objectId),
                              builder: (context, snapshotCount) {
                                if (snapshotCount.hasError) {
                                  return const Center(
                                    child: Text("Erro ao carregar os dados!"),
                                  );
                                } else if (snapshotCount.hasData) {
                                  final totalMoney =
                                      currentEvent.price * snapshotCount.data!;
                                  return Container(
                                    height: width * .5,
                                    width: width * .9,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.orange[700],
                                    ),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Relatório Geral",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: fontSizeSubtitle),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Convidados: ",
                                                style: TextStyle(
                                                    fontSize:
                                                        fontSizeTitle * .8,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "${snapshotCount.data}",
                                                style: TextStyle(
                                                    fontSize: fontSizeTitle,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              const Text("Ingresso:",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  currentEvent.price
                                                          .toStringAsFixed(0) +
                                                      " kz",
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              const Text("Total:",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  totalMoney
                                                          .toStringAsFixed(0) +
                                                      " kz",
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                            ],
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
                              })
                        ]);
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
