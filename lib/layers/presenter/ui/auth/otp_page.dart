import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:apupu_eventos/layers/presenter/routes/Routes.dart';
import '../../../core/auth_service/auth_service.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  //final auth = AuthControllerFirebase.instance;
  final codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //var args = ModalRoute.of(context)?.settings.arguments as Map;
    String phone = AuthService.phone;

    return WillPopScope(
      onWillPop: () async {
        AuthService.error = "";
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              ),
            ),
            elevation: 0,
          ),
          body: Container(
            margin: const EdgeInsets.only(left: 25, right: 25, top: 8),
            //alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      Utils.assetLogo,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Verificação de telefone",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Número: $phone",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Digite o codigo enviado no seu número de telefone",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Pinput(
                    //length: code.length,
                    //smsCodeMatcher: code,
                    length: 6,
                    controller: codeController,
                    showCursor: true,

                    defaultPinTheme: PinTheme(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.blue),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: AuthService.loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            child: const Text("Confirmar"),
                            onPressed: () {
                              submitCode(codeController.text);
                            },
                          ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Não recebeu nenhum código?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      child: Text("Enviar código novamente",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          )),
                      onPressed: () {
                        setState(() {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Aguarde o envio do código!")));
                          AuthService.verifyNumber(
                              phoneNumber: AuthService.phonePlusCodeCountry,
                              next: () {});
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomSheet: Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            child: const Text(
              "Aguarde a SMS com Código. Pode demorar 2 minutos!",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  submitCode(String smsCode) async {
    AuthService.smsCode = smsCode;

    setState(() {
      AuthService.loading = true;
    });
    await AuthService.getVerificationIdAndSmsCode(() {
      Navigator.pushNamed(context, Routes.CREATE_MANAGER);
    });
    if (AuthService.error.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Erro: ${AuthService.error}",
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
    setState(() {
      AuthService.error = "";
      AuthService.loading = false;
    });
  }
}
