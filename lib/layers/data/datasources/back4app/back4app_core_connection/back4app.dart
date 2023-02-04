// ignore_for_file: prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

abstract class Back4app {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    final keyApplicationId = "dpvWBtOqBHxJyhlvuuGUMLyAsv6tpkCUn23laGK4";
    final keyClientKey = "lezIENV8SHNuqDV8UkQvkPXHB1Lg0JhpCBI9ICa2";
    final keyParseServerUrl = "https://parseapi.back4app.com";
    final liveQueryUrl = "https://apupueventos.b4a.io";

    await Parse().initialize(
      keyApplicationId,
      keyParseServerUrl,
      clientKey: keyClientKey,
      autoSendSessionId: true,
      liveQueryUrl: liveQueryUrl,
    );
  }
}
