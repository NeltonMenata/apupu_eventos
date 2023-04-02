import 'package:apupu_eventos/layers/core/inject/inject.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'layers/data/datasources/back4app/back4app_core_connection/back4app.dart';
import 'layers/myapp/myapp.dart';

void main() async {
  //Inject.init();
  await Back4app.initialize();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}
