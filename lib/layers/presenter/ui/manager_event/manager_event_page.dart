import 'package:apupu_eventos/layers/core/inject/inject.dart';
import 'package:apupu_eventos/layers/domain/entities/event/event_entity.dart';
import 'package:apupu_eventos/layers/presenter/routes/Routes.dart';
import 'package:apupu_eventos/layers/presenter/ui/add_event/add_event_page.dart';
import 'package:apupu_eventos/layers/presenter/ui/create_worker/create_worker_page.dart';
import 'package:apupu_eventos/layers/presenter/ui/manager_event/manager_event_controller.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:url_launcher/url_launcher.dart';
import '../login/login_controller.dart';

class ManagerEventPage extends StatefulWidget {
  const ManagerEventPage({Key? key}) : super(key: key);

  @override
  State<ManagerEventPage> createState() => _ManagerEventPageState();
}

class _ManagerEventPageState extends State<ManagerEventPage>
    with TickerProviderStateMixin {
  final controller = getIt<ManagerEventController>();

  int currentIndex = 0;
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);

    super.initState();
  }

  void nextPage(int index) {
    setState(() {
      currentIndex = index;

      tabController.animateTo(index,
          duration: const Duration(milliseconds: 500), curve: Curves.bounceIn);
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

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
    double fontSizeTitle = width * .05;
    double fontSizeSubtitle = width * .035;
    double fontSizeTextButton = width * .06;

    return WillPopScope(
        onWillPop: () async {
          bool isWorker = workerObjectId == null;
          if (isWorker) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Deslize a barra lateral para Terminar Sessão!"),
              ),
            );
            return false;
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
            appBar: currentWorker == null
                ? AppBar(
                    centerTitle: true,
                    elevation: 0.0,
                    title: Text(
                      currentAdmin?.name ?? "Not connected",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    actions: [
                      Visibility(
                        visible: currentAdmin?.isAdmin == true,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.ADMIN_PANEL);
                          },
                          icon: const Icon(Icons.admin_panel_settings_outlined),
                        ),
                      ),
                      Visibility(
                        visible: loadingEvents,
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(6.0),
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                : null,
            drawer: currentWorker == null
                ? Drawer(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        children: [
                          UserAccountsDrawerHeader(
                            accountName: Text(
                              currentAdmin?.name ?? "Not connected",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            accountEmail: const Text("Gerente"),
                            currentAccountPicture: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(Utils.assetLogo)),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      "Criar Evento",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * .04,
                                      ),
                                    ),
                                    trailing: Icon(
                                      Icons.event,
                                      size: width * .10,
                                    ),
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed(Routes.ADD_EVENT);
                                    },
                                  ),
                                  ListTile(
                                    title: Text(
                                      "Criar Porteiro/Barman",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * .04,
                                      ),
                                    ),
                                    trailing: Icon(
                                      Icons.group_add_outlined,
                                      size: width * .10,
                                    ),
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed(Routes.CREATE_WORKER);
                                    },
                                  ),
                                  Visibility(
                                    visible: currentAdmin?.isAdmin == true,
                                    child: ListTile(
                                      title: Text(
                                        "Ver Gerenciadores da Plataforma",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: width * .04,
                                        ),
                                      ),
                                      trailing: Icon(
                                        Icons.group,
                                        size: width * .10,
                                      ),
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed(Routes.VIEW_MANAGER);
                                      },
                                    ),
                                  ),
                                  //const Spacer(),
                                  Text(
                                    "Suporte e Ajuda",
                                    style: TextStyle(
                                        fontSize: fontSizeTextButton * .85,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Arial Black"),
                                  ),
                                  ListTile(
                                    title: Text(
                                      "Facebook",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * .04,
                                      ),
                                    ),
                                    trailing: Icon(
                                      Icons.facebook_outlined,
                                      size: width * .10,
                                    ),
                                    onTap: () async {
                                      final uri = Uri.parse(
                                          "https://www.facebook.com/profile.php?id=100077996632399");
                                      await launchUrl(uri,
                                          mode: LaunchMode.externalApplication);
                                    },
                                  ),
                                  ListTile(
                                    title: Text(
                                      "Youtube",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * .04,
                                      ),
                                    ),
                                    trailing: Icon(
                                      Icons.video_library_rounded,
                                      size: width * .10,
                                    ),
                                    onTap: () async {
                                      final uri = Uri.parse(
                                          "https://youtube.com/playlist?list=PLtv_rjcck_Gzrm4fM-w2rrr1KMvVXgX9Z&si=QwOxci_5oarMbU8e");
                                      await launchUrl(uri,
                                          mode: LaunchMode.externalApplication);
                                    },
                                  ),
                                  ListTile(
                                    title: Text(
                                      "Actualizar",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * .04,
                                      ),
                                    ),
                                    trailing: Icon(
                                      Icons.system_update_alt_outlined,
                                      size: width * .10,
                                    ),
                                    onTap: () async {
                                      final uri = Uri.parse(
                                          "https://drive.google.com/file/d/1A0iyCXB06k6VjLeeQaW3l_tKgkN8Ntx2/view?usp=drive_link");
                                      await launchUrl(uri,
                                          mode: LaunchMode.externalApplication);
                                    },
                                  ),
                                  ListTile(
                                    title: Text(
                                      "Sobre",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * .04,
                                      ),
                                    ),
                                    trailing: Icon(
                                      Icons.priority_high_rounded,
                                      size: width * .10,
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.ABOUT);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Terminar Sessão",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: width * .04,
                              ),
                            ),
                            trailing: Icon(
                              Icons.logout_outlined,
                              color: Colors.red,
                              size: width * .10,
                            ),
                            onTap: () async {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Terminando a sessão. Aguarde!"),
                              ));

                              final user =
                                  await ParseUser.currentUser() as ParseUser?;
                              user?.logout();
                              LoginController.logout(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                : null,
            body: TabBarView(controller: tabController, children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 8.0, right: 8.0, bottom: 40),
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Gerencie seus Eventos",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: fontSizeTitle * 1.35,
                              fontFamily: "Arial Black",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
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
                                            nextPage(1);
                                          },
                                          child: Row(
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
                                                  child: Icon(
                                                Icons.arrow_forward_rounded,
                                                size: width * .09,
                                                color: Colors.white,
                                              ))
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
                                                    if (isDoorman != null) {
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
                                                        child: ConstrainedBox(
                                                          constraints:
                                                              BoxConstraints(
                                                            maxHeight:
                                                                width * .5,
                                                          ),
                                                          child: SizedBox(
                                                            //height: width * .45,
                                                            child: ClipRRect(
                                                              child: snapshot
                                                                          .data![
                                                                              index]
                                                                          .imgCartaz !=
                                                                      null
                                                                  ? snapshot.data![index].imgCartaz!.isNotEmpty &&
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
                                                                  "Area Normal:\n${separatorMoney("${snapshot.data![index].price}")} kz",
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
                                                                        "Area Vip:\n${separatorMoney("${snapshot.data![index].priceVip}")} kz",
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

              //################## ADD EVENT PAGE - PAGINA DE ADICIONAR EVENTOS

              const AddEventPage(),

              //################## CREATE WORKER PAGE - PAGINA DE CRIAR TRABALHADOR
              const CreateWorkerPage()
            ]),
            bottomSheet: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                //height: 40,
                padding: const EdgeInsets.only(top: 4.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: const Border.fromBorderSide(
                      BorderSide(color: Colors.black)),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black,
                      Colors.blue.shade900,
                    ],
                  ),
                ),
                child: workerObjectId == null
                    ? TabBar(
                        onTap: (index) {
                          if (index == 0) {
                            refreshEvents();
                          }
                        },
                        indicatorWeight: 3.5,
                        controller: tabController,
                        tabs: const [
                            Icon(
                              Icons.home_filled,
                              color: Colors.grey,
                              size: 35,
                            ),
                            Icon(
                              Icons.event_note_rounded,
                              color: Colors.grey,
                              size: 35,
                            ),
                            Icon(
                              Icons.group_add_outlined,
                              color: Colors.grey,
                              size: 35,
                            ),
                          ])
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

  bool loadingEvents = false;
  refreshEvents() async {
    setState(() {
      loadingEvents = true;
    });

    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      loadingEvents = false;
    });
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