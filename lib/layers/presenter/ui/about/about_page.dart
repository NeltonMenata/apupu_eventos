import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Sobre",
      )),
      body: Column(
        children: const [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "Sobre o Apupu Eventos",
              style: TextStyle(
                  fontFamily: "Arial Black",
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                "O que é?",
                style: TextStyle(
                    fontFamily: "Arial Black", fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  "Plataforma de Controle de Entrada e Saida de Pessoas, e Vendas."),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                "Onde usar?",
                style: TextStyle(
                    fontFamily: "Arial Black", fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  "Conferências; Festas; Casamentos; TalkShows; Palestras; Roullotes; Bar; etc; Todo e Qualquer evento pode usar o Apupu Eventos. "),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                "Requisitos?",
                style: TextStyle(
                    fontFamily: "Arial Black", fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Apenas acesso a internet."),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                "Criação?",
                style: TextStyle(
                    fontFamily: "Arial Black", fontWeight: FontWeight.bold),
              ),
              subtitle: Text("SystecAngo"),
            ),
          )
        ],
      ),
    );
  }
}
