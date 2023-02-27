import 'package:apupu_eventos/layers/presenter/routes/Routes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String title = "Home Page";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    const paddingLeft = 15.0;
    final paddingTop = height * 0.1;
    const paddingBottom = 15.0;
    return Scaffold(
      /*
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
              onPressed: () {}, icon: Image.asset("assets/logo/logo.png"))
        ],
      ),
      */
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: paddingLeft, top: paddingTop, bottom: paddingBottom),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Benvindo ao Apupu Eventos",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                  SizedBox(height: paddingBottom),
                  Text(
                    "Crie novos Eventos ou Gerencie seus eventos já adicionados (adicione pessoas)!",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      border: Border.all(
                        width: 1.5,
                      ),
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.black, Colors.blue]),
                      borderRadius: BorderRadius.circular(15)),
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white)),
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.ADD_EVENT);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                width: width * .35,
                                height: height * .15,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.event,
                                      size: width * .15,
                                      color: Colors.grey,
                                    ),
                                    const Text(
                                      "Adicionar novo Evento",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: _buttonStyle(Colors.blue, 15),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Routes.MANAGER_EVENT);
                              },
                              /*
                                icon: const Icon(Icons.settings_applications),
                                label: const Text("Gerenciar Eventos")),
                                */
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                width: width * .35,
                                height: height * .15,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.settings_applications,
                                      size: width * .15,
                                    ),
                                    const Text(
                                      "Gerenciar Eventos",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.srgbToLinearGamma(),
                                  image:
                                      AssetImage("assets/images/home_bg.jpg")),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  ButtonStyle _buttonStyle(Color color, double bRadius) {
    return ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(bRadius),
        ),
      ),
      backgroundColor: MaterialStateProperty.all<Color>(color),
    );
  }
}
