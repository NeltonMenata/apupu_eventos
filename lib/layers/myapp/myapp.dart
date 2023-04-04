import 'package:apupu_eventos/layers/presenter/routes/Routes.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apupu Eventos',
      //themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      //darkTheme: ThemeData.dark(),
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Comfortaa"),
      initialRoute: Routes.SPLASH,
      routes: Routes.routes(context),
    );
  }
}
