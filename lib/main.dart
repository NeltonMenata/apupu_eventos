import 'package:apupu_eventos/layers/core/inject/inject.dart';
import 'package:apupu_eventos/layers/presenter/ui/splash/splash_page_init.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'layers/data/datasources/back4app/back4app_core_connection/back4app.dart';
import 'layers/myapp/myapp.dart';

void main() async {
  runApp(const SplashPageInit());
  initInject();
  await Back4app.initialize();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}
