import 'package:flutter/material.dart';

import 'layers/data/datasources/back4app/back4app_core_connection/back4app.dart';
import 'layers/myapp/myapp.dart';

void main() async {
  await Back4app.initialize();
  runApp(const MyApp());
}
