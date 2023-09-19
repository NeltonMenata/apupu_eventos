import 'package:apupu_eventos/layers/core/inject/inject.dart';
import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:apupu_eventos/layers/presenter/routes/Routes.dart';
import 'package:apupu_eventos/layers/presenter/ui/manager_event/manager_event_controller.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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

    return WillPopScope(
        onWillPop: () async {
          bool isWorker = workerObjectId == null;
          if (isWorker) {
            return true;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Clique em Terminar Sessão para sair!"),
              ),
            );
            return false;
          }
        },
        child: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 16, left: 8.0, right: 8.0, bottom: 40),
                child: Center(
                  child: Column(
                    children: [
                      Visibility(
                          visible: currentWorker != null,
                          child: Container(
                            color: Colors.blue.shade600,
                            padding: const EdgeInsets.all(10),
                            child: Row(children: [
                              Icon(
                                Icons.person_pin,
                                size: width * .09,
                              ),
                              Text(currentWorker?.name ?? "",
                                  style: TextStyle(fontSize: width * .07))
                            ]),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Gerencie seus Eventos",
                          style: TextStyle(
                              fontSize: fontSizeTitle * 1.55,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 16),
                        child: Text(
                          "Clique  no evento para adicionar convidados!",
                          style: TextStyle(
                              fontSize: fontSizeTitle,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      FutureBuilder<List<EventEntity>>(
                        future: controller.getAllEvent(context, workerObjectId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return snapshot.data!.isEmpty
                                ? workerObjectId == null
                                    ? Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blue.shade800,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                    context, Routes.ADD_EVENT)
                                                .then(
                                                    (value) => setState(() {}));
                                          },
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 8,
                                                    child: Text(
                                                      "Nenhum Evento foi adicionado, clique aqui para criar um novo!",
                                                      style: TextStyle(
                                                          fontSize:
                                                              fontSizeTextButton,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: IconButton(
                                                        onPressed: () {
                                                          Navigator.pushNamed(
                                                                  context,
                                                                  Routes
                                                                      .ADD_EVENT)
                                                              .then((value) =>
                                                                  setState(
                                                                      () {}));
                                                        },
                                                        icon: Icon(
                                                          Icons
                                                              .arrow_forward_rounded,
                                                          size: width * .09,
                                                          color: Colors.white,
                                                        )),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
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
                                          final date = snapshot
                                              .data![index].dateOfRealization;

                                          return Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: Text(
                                                      snapshot.data![index].name
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "Arial Black",
                                                        fontSize:
                                                            fontSizeTitle * .9,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  snapshot.data![index]
                                                              .payment ??
                                                          false
                                                      ? const Icon(
                                                          Icons.check_circle)
                                                      : const SizedBox()
                                                ],
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          Colors.black,
                                                          Colors.blue.shade900
                                                        ])),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (isDoorman != null &&
                                                        isDoorman == false) {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              Routes
                                                                  .CREDIT_AND_SALE_WORKER,
                                                              arguments:
                                                                  snapshot.data![
                                                                      index]);
                                                      return;
                                                    }
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            Routes
                                                                .REGISTER_GUEST,
                                                            arguments: snapshot
                                                                .data![index]);
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 6,
                                                        child: SizedBox(
                                                          height: width * .45,
                                                          child: ClipRRect(
                                                            child: snapshot.data![index].imgCartaz !=
                                                                    null
                                                                ? snapshot
                                                                            .data![
                                                                                index]
                                                                            .imgCartaz!
                                                                            .isNotEmpty &&
                                                                        snapshot.data![index].imgCartaz! !=
                                                                            Utils
                                                                                .assetLogo
                                                                    ? CachedNetworkImage(
                                                                        imageUrl: snapshot
                                                                            .data![index]
                                                                            .imgCartaz!,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      )
                                                                    : Image.asset(
                                                                        Utils
                                                                            .assetLogo,
                                                                        fit: BoxFit
                                                                            .cover)
                                                                : Image.asset(
                                                                    Utils
                                                                        .assetLogo,
                                                                    fit: BoxFit
                                                                        .cover),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            //  radius: circleAvatarSize,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            6.0),
                                                                child: Text(
                                                                  "Data: \n${date.day}/${date.month}/${date.year}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          fontSizeSubtitle,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            6.0),
                                                                child: Text(
                                                                  "Organização:\n${snapshot.data![index].organization}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          fontSizeTitle *
                                                                              .7,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            6.0),
                                                                child: Text(
                                                                  "Normal:\n${separatorMoney("${snapshot.data![index].price}")} kz",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          fontSizeSubtitle,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ),
                                                              snapshot.data![index]
                                                                          .priceVip !=
                                                                      null
                                                                  ? Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          bottom:
                                                                              6.0),
                                                                      child:
                                                                          Text(
                                                                        "Vip:\n${separatorMoney("${snapshot.data![index].priceVip}")} kz",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                fontSizeSubtitle,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
                                                                      ),
                                                                    )
                                                                  : const SizedBox()
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              /*
                                              ListTile(
                                                minLeadingWidth: imgCartazSize,
                                                leading: SizedBox(
                                                  //height: imgCartazSize,
                                                  width: imgCartazSize,
                                                  child: ClipRRect(
                                                    child: snapshot.data![index]
                                                                .imgCartaz !=
                                                            null
                                                        ? snapshot
                                                                    .data![
                                                                        index]
                                                                    .imgCartaz!
                                                                    .isNotEmpty &&
                                                                snapshot
                                                                        .data![
                                                                            index]
                                                                        .imgCartaz! !=
                                                                    Utils
                                                                        .assetLogo
                                                            ? CachedNetworkImage(
                                                                imageUrl: snapshot
                                                                    .data![
                                                                        index]
                                                                    .imgCartaz!,
                                                                fit: BoxFit
                                                                    .cover,
                                                              )
                                                            : Image.asset(
                                                                Utils.assetLogo,
                                                                fit: BoxFit
                                                                    .cover)
                                                        : Image.asset(
                                                            Utils.assetLogo,
                                                            fit: BoxFit.cover),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    //  radius: circleAvatarSize,
                                                  ),
                                                ),
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Card(
                                                      color: snapshot
                                                                  .data![index]
                                                                  .payment ??
                                                              false
                                                          ? Colors
                                                              .green.shade700
                                                          : Colors.white,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text(
                                                          snapshot
                                                              .data![index].name
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                            fontSize:
                                                                fontSizeTitle,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: snapshot
                                                                        .data![
                                                                            index]
                                                                        .payment ??
                                                                    false
                                                                ? Colors.white
                                                                : Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 4.0),
                                                      child: Text(
                                                        snapshot.data![index]
                                                            .organization,
                                                        style: TextStyle(
                                                            fontSize:
                                                                fontSizeTitle,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                subtitle: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    "${date.day}/${date.month}/${date.year}",
                                                    style: TextStyle(
                                                        fontSize:
                                                            fontSizeSubtitle,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                                trailing: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "${separatorMoney("${snapshot.data![index].price}")} kz",
                                                      style: TextStyle(
                                                          fontSize:
                                                              fontSizeSubtitle,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    snapshot.data![index]
                                                                .priceVip !=
                                                            null
                                                        ? Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              const Flexible(
                                                                child: Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                      .amber,
                                                                ),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                  "${separatorMoney("${snapshot.data![index].priceVip}")} kz",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          fontSizeSubtitle,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white),
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
                                                        Routes
                                                            .CREDIT_AND_SALE_WORKER,
                                                        arguments: snapshot
                                                            .data![index]);
                                                    return;
                                                  }
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          Routes.REGISTER_GUEST,
                                                          arguments: snapshot
                                                              .data![index]);
                                                },
                                              ),
                                              */

                                              // const Divider(
                                              //   color: Colors.grey,
                                              // ),
                                              const SizedBox(
                                                height: 24,
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
                    ],
                  ),
                ),
              ),
            ),
            bottomSheet: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: workerObjectId == null
                    ? TextButton(
                        onPressed: () {},
                        child: const Text(
                            "Volte sempre nesta tela para gerenciar os eventos criados!"),
                      )
                    : TextButton(
                        onPressed: () {
                          LoginController.logout(context);
                        },
                        child: Text(
                          "Terminar Sessão",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.red,
                              fontSize: fontSizeSubtitle),
                        ),
                      ),
              ), /* Git Hub */
            ),
          ),
        ));
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