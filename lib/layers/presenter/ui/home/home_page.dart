import 'package:apupu_eventos/layers/presenter/geral_components/buttons/big_button_navigation.dart';
import 'package:apupu_eventos/layers/presenter/routes/Routes.dart';
import '../login/login_controller.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String title = "Home Page";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    const paddingLeft = 10.0;
    final paddingTop = height * 0.03;
    const paddingBottom = 15.0;
    final fontSizeTitle = width * .08;
    final fontSizeSubtitle = width * .05;
    //final allPadding = width * .020;

    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Clique em Terminar Sessão para sair!"),
          ),
        );
        return false;
      },
      child: Scaffold(
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(
                    currentAdmin?.name ?? "Not connected",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  accountEmail: const Text("Gerenciador"),
                  currentAccountPicture: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(Utils.assetLogo)),
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
                    Navigator.of(context).pushNamed(Routes.CREATE_WORKER);
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
                      Navigator.of(context).pushNamed(Routes.VIEW_MANAGER);
                    },
                  ),
                ),
                const Spacer(),
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
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Terminando a sessão. Aguarde!"),
                    ));

                    final user = await ParseUser.currentUser() as ParseUser?;
                    await user?.logout();
                    LoginController.logout(context);
                  },
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
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
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: paddingLeft, top: paddingTop, bottom: paddingBottom),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Benvindo ao Apupu Eventos",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: fontSizeTitle),
                    ),
                    const SizedBox(height: paddingBottom),
                    Text(
                      "Crie novos Eventos ou Gerencie seus eventos já adicionados (manuseie a entrada/saída de convidados)",
                      style: TextStyle(fontSize: fontSizeSubtitle),
                    )
                  ],
                ),
              ),
              BigButtonNavigation(
                  title: "Adicionar novo Evento",
                  icon: Icons.event,
                  action: () {
                    Navigator.pushNamed(context, Routes.ADD_EVENT);
                  }),
              BigButtonNavigation(
                  title: "Gerenciar Eventos",
                  icon: Icons.settings_applications,
                  action: () {
                    Navigator.pushNamed(context, Routes.MANAGER_EVENT);
                  }),
              BigButtonNavigation(
                  title: "Criar Porteiro/Barman",
                  icon: Icons.group_add_outlined,
                  action: () {
                    Navigator.of(context).pushNamed(Routes.CREATE_WORKER);
                  }),
              BigButtonNavigation(
                title: "Terminar Sessão",
                icon: Icons.logout,
                color: Colors.red,
                action: () async {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Terminando a sessão. Aguarde!"),
                  ));

                  final user = await ParseUser.currentUser() as ParseUser?;
                  await user?.logout();
                  LoginController.logout(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
