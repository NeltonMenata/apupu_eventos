import 'package:apupu_eventos/layers/core/inject/inject.dart';
import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:apupu_eventos/layers/presenter/ui/report_event/report_event_controller.dart';
import 'package:flutter/material.dart';

import '../../geral_components/buttons/big_button_navigation.dart';
import '../../routes/Routes.dart';

class MenuReportEventPage extends StatefulWidget {
  const MenuReportEventPage({Key? key}) : super(key: key);

  @override
  State<MenuReportEventPage> createState() => _MenuReportEventPageState();
}

class _MenuReportEventPageState extends State<MenuReportEventPage> {
  final controller = getIt<ReportEventController>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    const paddingLeft = 10.0;
    final paddingTop = height * 0.06;
    const paddingBottom = 15.0;
    final fontSizeTitle = width * .08;
    final fontSizeSubtitle = width * .05;

    final currentEvent =
        ModalRoute.of(context)!.settings.arguments as EventEntity;

    return Scaffold(
      appBar: AppBar(title: const Text("Relatório do Evento")),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(
                left: paddingLeft,
                right: paddingLeft,
                top: paddingTop,
                bottom: paddingBottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Relatório do Evento - ${currentEvent.name}",
                  style: TextStyle(
                      fontFamily: "Arial Black",
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeTitle),
                ),
                const SizedBox(height: paddingBottom),
                Text(
                  "Consulte a quantidade de convidados que participaram deste evento, produtos vendidos e o valor monetário arrecadado pelo cartão de consumo.",
                  style: TextStyle(fontSize: fontSizeSubtitle),
                )
              ],
            ),
          ),
          BigButtonNavigation(
              title: "Relatório de Convidados",
              icon: Icons.dashboard,
              action: () {
                Navigator.of(context)
                    .pushNamed(Routes.REPORT_EVENT, arguments: currentEvent);
              }),
          BigButtonNavigation(
              title: "Relatório de Produtos Vendidos",
              icon: Icons.dashboard,
              action: () {
                Navigator.of(context)
                    .pushNamed(Routes.REPORT_SALE, arguments: currentEvent);
              }),
          BigButtonNavigation(
              title: "Relatório de Créditos - Cartão de Consumo",
              icon: Icons.dashboard,
              action: () {
                Navigator.of(context)
                    .pushNamed(Routes.REPORT_CREDIT, arguments: currentEvent);
              }),
        ]),
      ),
    );
  }
}
