import 'package:firebase_core/firebase_core.dart';

abstract class FirebaseCore {
  static Future<void> init() async {
    await Firebase.initializeApp();
  }
}
