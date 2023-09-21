import 'package:apupu_eventos/layers/presenter/geral_components/buttons/big_button_navigation.dart';
import 'package:apupu_eventos/layers/presenter/routes/Routes.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/event/event_entity.dart';

class CreditAndSaleWorker extends StatelessWidget {
  const CreditAndSaleWorker({Key? key}) : super(key: key);

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
        ModalRoute.of(context)?.settings.arguments as EventEntity;
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: EdgeInsets.only(
              left: paddingLeft, top: paddingTop, bottom: paddingBottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Crédito & Venda",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: fontSizeTitle),
              ),
              const SizedBox(height: paddingBottom),
              Text(
                "Recarregue o cartão de consumo e faça venda de consumíveis respectivamente",
                style: TextStyle(fontSize: fontSizeSubtitle),
              )
            ],
          ),
        ),
        BigButtonNavigation(
            title: "Adicionar Convidados",
            icon: Icons.person_add,
            action: () {
              Navigator.of(context)
                  .pushNamed(Routes.REGISTER_GUEST, arguments: currentEvent);
            }),
        BigButtonNavigation(
            title: "Carregar Cartão de Consumo",
            icon: Icons.credit_card,
            action: () {
              Navigator.of(context)
                  .pushNamed(Routes.MAKE_CREDIT, arguments: currentEvent);
            }),
        BigButtonNavigation(
            title: "Realizar Vendas",
            icon: Icons.fastfood_outlined,
            action: () {
              Navigator.of(context)
                  .pushNamed(Routes.MAKE_SALE, arguments: currentEvent);
            }),
      ]),
    );
  }
}
