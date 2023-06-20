import 'package:apupu_eventos/layers/core/inject/inject.dart';
import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:apupu_eventos/layers/presenter/geral_components/scaffold_general/scaffold_general.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/worker/worker_entity.dart';
import 'manager_worker_controller.dart';

class ManagerWorkerPage extends StatefulWidget {
  ManagerWorkerPage({Key? key}) : super(key: key);
  final controller = getIt<ManagerWorkerController>();
  @override
  State<ManagerWorkerPage> createState() => _ManagerWorkerPageState();
}

class _ManagerWorkerPageState extends State<ManagerWorkerPage> {
  @override
  Widget build(BuildContext context) {
    final currentEvent =
        ModalRoute.of(context)!.settings.arguments as EventEntity;

    return Scaffold(
      body: SingleChildScrollView(
        child: ScaffoldGeneral(
          title: currentEvent.name,
          subtitle: "Adicione ou Remove Trabalhadores do Evento",
          body: FutureBuilder<List<WorkerEntity>>(
              future: widget.controller.getAllWorker(context),
              builder: (context, snapshotWorker) {
                if (snapshotWorker.hasError) {
                  return const Center(
                    child: Text("Erro ao Carregar os Dados"),
                  );
                } else if (snapshotWorker.hasData) {
                  return Column(children: [
                    ...List.generate(snapshotWorker.data!.length, (index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: snapshotWorker.data![index].isDoorman
                                ? CircleAvatar(
                                    backgroundColor: Colors.amber[700],
                                  )
                                : CircleAvatar(
                                    backgroundColor: Colors.brown[700],
                                  ),
                            title: Text(
                              snapshotWorker.data![index].name,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "U: " +
                                        snapshotWorker.data![index].username,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        backgroundColor: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "P: " +
                                        snapshotWorker.data![index].password,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        backgroundColor: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                            trailing: SizedBox(
                              width: 50,
                              height: 50,
                              child: FutureBuilder<bool>(
                                future: widget.controller.verifyWorkerEvent(
                                    snapshotWorker.data![index].objectId!,
                                    currentEvent.objectId),
                                builder: (context, snapshotVerify) {
                                  if (snapshotVerify.hasError) {
                                    return const Text("Erro");
                                  } else if (snapshotVerify.hasData) {
                                    if (snapshotVerify.data!) {
                                      return CircleAvatar(
                                        backgroundColor: Colors.red[700],
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                backgroundColor: Colors.red,
                                                content: Text("Removendo " +
                                                    snapshotWorker
                                                        .data![index].name +
                                                    "!"),
                                              ));
                                              widget.controller
                                                  .removeWorkerEvent(
                                                      snapshotWorker
                                                          .data![index]
                                                          .objectId!,
                                                      currentEvent.objectId);
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.remove_outlined,
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return CircleAvatar(
                                        backgroundColor: Colors.green[700],
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                backgroundColor: Colors.green,
                                                content: Text("Adicionando " +
                                                    snapshotWorker
                                                        .data![index].name +
                                                    "!"),
                                              ));
                                              widget.controller.addWorkerEvent(
                                                  snapshotWorker
                                                      .data![index].objectId!,
                                                  currentEvent.objectId);
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.add_outlined,
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    }
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          const Divider(
                            color: Colors.amber,
                          )
                        ],
                      );
                    })
                  ]);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Text(
            "Porteiro: ",
            style: TextStyle(
              color: Colors.amber[700],
              fontWeight: FontWeight.bold,
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.amber[700],
          ),
          const Spacer(),
          Text(
            "Vendas: ",
            style: TextStyle(
              color: Colors.brown[700],
              fontWeight: FontWeight.bold,
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.brown[700],
          ),
        ]),
      ),
    );
  }
}
