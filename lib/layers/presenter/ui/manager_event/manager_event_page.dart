import 'package:apupu_eventos/layers/core/inject/inject.dart';
import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:apupu_eventos/layers/presenter/routes/Routes.dart';
import 'package:apupu_eventos/layers/presenter/ui/manager_event/manager_event_controller.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../geral_components/scaffold_general/scaffold_general.dart';
import '../login/login_controller.dart';

class ManagerEventPage extends StatefulWidget {
  const ManagerEventPage({Key? key}) : super(key: key);

  @override
  State<ManagerEventPage> createState() => _ManagerEventPageState();
}

class _ManagerEventPageState extends State<ManagerEventPage> {
  final controller = getIt<ManagerEventController>();
  @override
  Widget build(BuildContext context) {
    final workerObjectId =
        ModalRoute.of(context)!.settings.arguments as String?;

    final isDoorman = currentWorker?.isDoorman;
    //final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    //const paddingLeft = 15.0;
    //final paddingTop = height * 0.1;
    //const paddingBottom = 15.0;
    //const crossStart = CrossAxisAlignment.start;
    double fontSizeTitle = width * .045;
    double fontSizeSubtitle = width * .035;
    double fontSizeTextButton = width * .06;
    final imgCartazSize = width * .15;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: ScaffoldGeneral(
            title:
                "Gerencie seus Eventos, clique  no evento para adicionar convidados!",
            subtitle: "",
            body: FutureBuilder<List<EventEntity>>(
              future: controller.getAllEvent(context, workerObjectId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!.isEmpty
                      ? workerObjectId == null
                          ? TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.ADD_EVENT)
                                    .then((value) => setState(() {}));
                              },
                              child: Column(
                                children: [
                                  Row(
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
                                                .then(
                                                    (value) => setState(() {}));
                                          },
                                          icon: Icon(
                                            Icons.arrow_forward_rounded,
                                            size: width * .09,
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Nenhum Evento foi a adicionado você!",
                                style: TextStyle(
                                    fontSize: fontSizeTextButton,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            )
                      : Column(
                          children: [
                            ...List.generate(
                              snapshot.data!.length,
                              ((index) {
                                final date =
                                    snapshot.data![index].dateOfRealization;

                                return Column(
                                  children: [
                                    ListTile(
                                      minLeadingWidth: imgCartazSize,
                                      leading: SizedBox(
                                        //height: imgCartazSize,
                                        width: imgCartazSize,
                                        child: ClipRRect(
                                          child: snapshot
                                                      .data![index].imgCartaz !=
                                                  null
                                              ? snapshot.data![index].imgCartaz!
                                                          .isNotEmpty &&
                                                      snapshot.data![index]
                                                              .imgCartaz! !=
                                                          Utils.assetLogo
                                                  ? CachedNetworkImage(
                                                      imageUrl: snapshot
                                                          .data![index]
                                                          .imgCartaz!,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.asset(Utils.assetLogo,
                                                      fit: BoxFit.cover)
                                              : Image.asset(Utils.assetLogo,
                                                  fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          //  radius: circleAvatarSize,
                                        ),
                                      ),
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                snapshot.data![index].name
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                    fontSize: fontSizeTitle,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            child: Text(
                                              snapshot
                                                  .data![index].organization,
                                              style: TextStyle(
                                                  fontSize: fontSizeTitle,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "${date.day}/${date.month}/${date.year}",
                                          style: TextStyle(
                                              fontSize: fontSizeSubtitle,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        ),
                                      ),
                                      trailing: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            separatorMoney(
                                                "${snapshot.data![index].price} kz"),
                                            style: TextStyle(
                                                fontSize: fontSizeSubtitle,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          snapshot.data![index].priceVip != null
                                              ? Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Flexible(
                                                      child: Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        separatorMoney(
                                                          snapshot.data![index]
                                                                  .priceVip
                                                                  .toString() +
                                                              " kz",
                                                        ),
                                                        style: TextStyle(
                                                            fontSize:
                                                                fontSizeSubtitle,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : const SizedBox()
                                        ],
                                      ),
                                      onTap: () {
                                        if (isDoorman != null &&
                                            isDoorman == false) {
                                          Navigator.of(context).pushNamed(
                                              Routes.CREDIT_AND_SALE_WORKER,
                                              arguments: snapshot.data![index]);
                                          return;
                                        }
                                        Navigator.of(context).pushNamed(
                                            Routes.REGISTER_GUEST,
                                            arguments: snapshot.data![index]);
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
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: workerObjectId == null
              ? const Text(
                  "Volte sempre nesta tela para gerenciar os eventos criados!")
              : TextButton(
                  onPressed: () {
                    LoginController.logout(context);
                  },
                  child: Text(
                    "Terminar Sessão",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: fontSizeSubtitle),
                  ),
                ),
        ), /* Git Hub */
      ),
    );
  }
}
/*

   splits {
    abi {
        enable true
        reset()
        include 'x86','x86_64','armeabi-v7a','mips','mips64','arm64-v8a'
        universalApk true
    }
}

*/