import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static String error = "";
  static String smsCode = "";
  static String id = "";
  static bool loading = false;
  static String phone = "";
  static String password = "";
  static String phonePlusCodeCountry = "";

  static Future<void> verifyNumber(
      {required String phoneNumber, required Function next}) async {
    phonePlusCodeCountry = phoneNumber;
    const maximumAttemptTime = Duration(seconds: 60);
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: maximumAttemptTime,
          verificationCompleted: (AuthCredential credential) async {
            await _firebaseAuth.signInWithCredential(credential);
            next();
          },
          verificationFailed: (FirebaseAuthException exception) {
            error = exception.message.toString();
          },
          codeSent: (String verificationId, int? resendToken) async {
            id = verificationId;
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            id = verificationId;
          });
    } catch (e) {
      error = e.toString();
    }
  }

  static Future<void> getVerificationIdAndSmsCode(Function next) async {
    try {
      final credential =
          PhoneAuthProvider.credential(verificationId: id, smsCode: smsCode);
      await _firebaseAuth.signInWithCredential(credential);
      next();
    } catch (e) {
      error = e.toString();
    }
  }
}
