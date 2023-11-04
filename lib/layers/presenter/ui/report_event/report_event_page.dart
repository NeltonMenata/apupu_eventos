import 'package:apupu_eventos/layers/core/inject/inject.dart';
import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:apupu_eventos/layers/presenter/ui/report_event/report_event_controller.dart';
import 'package:apupu_eventos/layers/presenter/utils/widget_to_image.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/report_guest/report_guest_entity.dart';
import '../../utils/utils.dart';

class ReportEventPage extends StatefulWidget {
  const ReportEventPage({Key? key}) : super(key: key);

  @override
  State<ReportEventPage> createState() => _ReportEventPageState();
}

class _ReportEventPageState extends State<ReportEventPage> {
  GlobalKey key1qrcode = GlobalKey();
  final controller = getIt<ReportEventController>();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final currentEvent =
        ModalRoute.of(context)!.settings.arguments as EventEntity;

    return Scaffold(
      appBar: AppBar(title: const Text("Relatório de Convidados"), actions: [
        IconButton(
            onPressed: () {
              Utils.capture(key1qrcode, context);
            },
            icon: const Icon(Icons.share_outlined, color: Colors.white)),
      ]),
      body: SingleChildScrollView(
        child: WidgetToImage(builder: (key) {
          key1qrcode = key;
          return ColoredBox(
            color: Colors.grey.shade200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: FutureBuilder<List<ReportGuestEntity>>(
                      future: controller.countGuestWorker(
                          "", currentEvent.objectId),
                      builder: (context, snapshotWorker) {
                        if (snapshotWorker.hasError) {
                          return const Center(
                            child: Text("Erro ao Carregar dados!"),
                          );
                        } else if (snapshotWorker.hasData) {
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...snapshotWorker.data!.map(
                                  (e) => ListTile(
                                    leading: CircleAvatar(
                                      child: Text(
                                        e.workerName[0].toUpperCase(),
                                        style: TextStyle(
                                            fontSize: width * .06,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                    title: Text(
                                      e.workerName.toUpperCase(),
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: width * .046,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    subtitle: Text(
                                      "Normal: ${e.normal} | Vip: ${e.vip}",
                                      style: TextStyle(
                                          fontSize: width * .045,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    trailing: Text(
                                        separatorMoney(
                                                "${(e.normal * currentEvent.price) + (e.vip * currentEvent.priceVip!)}") +
                                            " kz",
                                        style: TextStyle(
                                          fontSize: width * .046,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
                FutureBuilder<ReportGuestEntity>(
                    future: controller.countGuestEvent(currentEvent.objectId),
                    builder: (context, snapshotEvent) {
                      if (snapshotEvent.hasError) {
                        return const Center(
                          child: Text("Erro ao carregar os dados!"),
                        );
                      } else if (snapshotEvent.hasData) {
                        return Padding(
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
                                      "Relatório Geral",
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
                                          "Convidados Normal: ${snapshotEvent.data!.normal}",
                                          style: TextStyle(
                                              fontSize: width * .047,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Convidados Vip: ${snapshotEvent.data!.vip}",
                                          style: TextStyle(
                                              fontSize: width * .047,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Ingresso Normal: " +
                                              separatorMoney(
                                                  "${currentEvent.price}") +
                                              " kz",
                                          style: TextStyle(
                                              fontSize: width * .047,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Ingresso Vip: " +
                                              separatorMoney(
                                                  "${currentEvent.priceVip}") +
                                              " kz",
                                          style: TextStyle(
                                              fontSize: width * .047,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Total Geral: " +
                                              separatorMoney(
                                                  "${(currentEvent.priceVip! * snapshotEvent.data!.vip) + (currentEvent.price * snapshotEvent.data!.normal)}") +
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
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    })
              ],
            ),
          );
        }),
      ),
    );
  }
}
