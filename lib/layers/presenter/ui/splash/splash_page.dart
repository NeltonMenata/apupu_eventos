import 'package:apupu_eventos/layers/presenter/routes/Routes.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

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
              padding: EdgeInsets.all(10),
              child: SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(
                  "assets/logo/logo.png",
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
    _login();
    super.initState();
  }

  Future<void> _login() async {
    final currentUser = await ParseUser.currentUser() as ParseUser?;
    Future.delayed(const Duration(seconds: 5), () {
      if (currentUser == null) {
        Navigator.pushReplacementNamed(context, Routes.LOGIN);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.HOME, (route) => false);
      }
    });
  }
}
