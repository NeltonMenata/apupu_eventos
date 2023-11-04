import 'package:apupu_eventos/layers/core/inject/inject.dart';
import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:apupu_eventos/layers/presenter/routes/Routes.dart';
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
    final width = MediaQuery.of(context).size.width;
    final currentEvent =
        ModalRoute.of(context)!.settings.arguments as EventEntity;
    double fontSizeTitle = width * .045;
    //double fontSizeSubtitle = width * .035;
    //double fontSizeTextButton = width * .06;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    currentEvent.name,
                    style: TextStyle(
                        fontSize: fontSizeTitle * 1.55,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                  child: Text(
                    "Adicione ou Remove Trabalhadores deste Evento",
                    style: TextStyle(
                        fontSize: fontSizeTitle, fontWeight: FontWeight.bold),
                  ),
                ),
                FutureBuilder<List<WorkerEntity>>(
                    future: widget.controller.getAllWorker(context),
                    builder: (context, snapshotWorker) {
                      if (snapshotWorker.hasError) {
                        return const Center(
                          child: Text("Erro ao Carregar os Dados"),
                        );
                      } else if (snapshotWorker.hasData) {
                        if (snapshotWorker.data!.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: width,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10)),
                              child: GestureDetector(
                                onTap: () async {
                                  await Navigator.pushNamed(
                                      context, Routes.CREATE_WORKER);
                                  setState(() {});
                                },
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Lista de Trabalhadores vazia! \nClique para adicionar um trabalhador neste evento.",
                                        style: TextStyle(
                                            fontSize: width * .055,
                                            color: Colors.white),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else if (snapshotWorker.data![0].error != null) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: width,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "${snapshotWorker.data?[0].error}",
                                style: TextStyle(
                                    fontSize: width * .055,
                                    color: Colors.white),
                              ),
                            ),
                          );
                        } else {
                          return Column(children: [
                            ...List.generate(snapshotWorker.data!.length,
                                (index) {
                              return Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(colors: [
                                          Colors.black,
                                          Colors.blue.shade900
                                        ])),
                                    child: ListTile(
                                      leading: snapshotWorker
                                              .data![index].isDoorman
                                          ? CircleAvatar(
                                              backgroundColor:
                                                  Colors.amber[700],
                                              child: Text(
                                                snapshotWorker
                                                    .data![index].name[0]
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: width * .06,
                                                ),
                                              ),
                                            )
                                          : CircleAvatar(
                                              backgroundColor:
                                                  Colors.brown[500],
                                              child: Text(
                                                snapshotWorker
                                                    .data![index].name[0]
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: width * .06,
                                                ),
                                              ),
                                            ),
                                      title: Text(
                                        snapshotWorker.data![index].name,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: fontSizeTitle),
                                      ),
                                      subtitle: Card(
                                        color: Colors.grey,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Username: " +
                                                      snapshotWorker
                                                          .data![index]
                                                          .username,
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade900,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "Senha: " +
                                                      snapshotWorker
                                                          .data![index]
                                                          .password,
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade900,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ]),
                                        ),
                                      ),
                                      trailing: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: FutureBuilder<bool>(
                                          future: widget.controller
                                              .verifyWorkerEvent(
                                                  snapshotWorker
                                                      .data![index].objectId!,
                                                  currentEvent.objectId),
                                          builder: (context, snapshotVerify) {
                                            if (snapshotVerify.hasError) {
                                              return const Text("Erro");
                                            } else if (snapshotVerify.hasData) {
                                              if (snapshotVerify.data!) {
                                                return CircleAvatar(
                                                  backgroundColor:
                                                      Colors.red[700],
                                                  child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          backgroundColor:
                                                              Colors.red,
                                                          content: Text(
                                                              "Removendo " +
                                                                  snapshotWorker
                                                                      .data![
                                                                          index]
                                                                      .name +
                                                                  "!"),
                                                        ));
                                                        widget.controller
                                                            .removeWorkerEvent(
                                                                snapshotWorker
                                                                    .data![
                                                                        index]
                                                                    .objectId!,
                                                                currentEvent
                                                                    .objectId);
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
                                                  backgroundColor:
                                                      Colors.green[700],
                                                  child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          backgroundColor:
                                                              Colors.green,
                                                          content: Text(
                                                              "Adicionando " +
                                                                  snapshotWorker
                                                                      .data![
                                                                          index]
                                                                      .name +
                                                                  "!"),
                                                        ));
                                                        widget.controller
                                                            .addWorkerEvent(
                                                                snapshotWorker
                                                                    .data![
                                                                        index]
                                                                    .objectId!,
                                                                currentEvent
                                                                    .objectId);
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
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
                              );
                            })
                          ]);
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ],
            ),
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
              "Barman: ",
              style: TextStyle(
                color: Colors.brown[500],
                fontWeight: FontWeight.bold,
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.brown[500],
            ),
          ]),
        ),
      ),
    );
  }
}
