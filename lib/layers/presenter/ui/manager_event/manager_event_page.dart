import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:apupu_eventos/layers/presenter/routes/Routes.dart';
import 'package:apupu_eventos/layers/presenter/ui/manager_event/manager_event_controller.dart';
import 'package:flutter/material.dart';

import '../../geral_components/scaffold_general/scaffold_general.dart';

class ManagerEventPage extends StatefulWidget {
  const ManagerEventPage({Key? key}) : super(key: key);

  @override
  State<ManagerEventPage> createState() => _ManagerEventPageState();
}

class _ManagerEventPageState extends State<ManagerEventPage> {
  final controller = ManagerEventController();
  @override
  Widget build(BuildContext context) {
    //final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    //const paddingLeft = 15.0;
    //final paddingTop = height * 0.1;
    //const paddingBottom = 15.0;
    //const crossStart = CrossAxisAlignment.start;
    double fontSizeTitle = width * .045;
    double fontSizeSubtitle = width * .035;
    double fontSizeTextButton = width * .06;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: ScaffoldGeneral(
            title:
                "Gerencie seus Eventos, clique  no evento para adicionar convidados!",
            subtitle: "",
            body: FutureBuilder<List<EventEntity>>(
              future: controller.getAllEvent(context),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!.isEmpty
                      ? TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.ADD_EVENT)
                                .then((value) => setState(() {}));
                          },
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  "Nenhum Evento foi adicionado, clique aqui criar um novo!",
                                  style: TextStyle(
                                      fontSize: fontSizeTextButton,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                            context, Routes.ADD_EVENT)
                                        .then((value) => setState(() {}));
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_rounded,
                                    size: width * .09,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            ...List.generate(
                              snapshot.data!.length,
                              ((index) {
                                final date =
                                    snapshot.data![index].dateOfrealization;
                                return Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        snapshot.data![index].name,
                                        style: TextStyle(
                                            fontSize: fontSizeTitle,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        "${date.day}/${date.month}/${date.year}",
                                        style: TextStyle(
                                            fontSize: fontSizeSubtitle,
                                            color: Colors.grey),
                                      ),
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed(Routes.REGISTER_GUEST);
                                      },
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                    )
                                  ],
                                );
                              }),
                            )
                          ],
                        );
                } else if (snapshot.hasError) {
                  return const Text("Erro ao carregar dados!");
                }
                return const CircularProgressIndicator();
              },
            ),
          ),

          /*
           Padding(
            padding: EdgeInsets.only(
                left: paddingLeft, top: paddingTop, bottom: paddingBottom),
            child: Column(
              crossAxisAlignment: crossStart,
              children: [
                const Text(
                  "Gerencie seus Eventos, clique  no evento para adicionar convidados!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
                FutureBuilder<List<EventEntity>>(
                    future: controller.getAllEvent(context),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            ...List.generate(
                              snapshot.data!.length,
                              ((index) {
                                final date =
                                    snapshot.data![index].dateOfrealization;
                                return ListTile(
                                  title: Text(
                                    snapshot.data![index].name,
                                    style: TextStyle(
                                        fontSize: fontSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                      "${date.day}/${date.month}/${date.year}"),
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed("/register_guest");
                                  },
                                );
                              }),
                            )
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return const Text("Erro ao carregar dados!");
                      }
                      return const CircularProgressIndicator();
                    }),
              ],
            ),
          ),
          */
        ),
      ),
    );
  }
}
