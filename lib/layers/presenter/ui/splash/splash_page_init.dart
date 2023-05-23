import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/material.dart';

class SplashPageInit extends StatefulWidget {
  const SplashPageInit({Key? key}) : super(key: key);

  @override
  State<SplashPageInit> createState() => _SplashPageInitState();
}

class _SplashPageInitState extends State<SplashPageInit> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                  child: Image.asset(
                    Utils.assetLogo,
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
      ),
    );
  }
}
