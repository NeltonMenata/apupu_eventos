import 'package:apupu_eventos/layers/presenter/routes/Routes.dart';
import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../../domain/entities/manager/manager_entity.dart';
import '../login/login_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 100,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    Utils.assetLogo,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Apupu Eventos",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "O Melhor Gerenciador de Eventos na Palma da Mão!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
              ),
            )
          ]),
    );
  }

  @override
  void initState() {
    _login().then((value) => null);
    super.initState();
  }

  Future<void> _login() async {
    final currentUser = await ParseUser.currentUser() as ParseUser?;

    await Future.delayed(const Duration(seconds: 2), () {
      if (currentUser == null) {
        Navigator.pushReplacementNamed(context, Routes.LOGIN);
      } else {
        currentAdmin = ManagerEntity(
            name: currentUser.get("name"),
            objectId: currentUser.objectId,
            username: currentUser.get("username"));
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.HOME, (route) => false);
      }
    });
  }
}
