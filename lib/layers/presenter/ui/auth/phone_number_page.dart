import 'package:apupu_eventos/layers/presenter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:apupu_eventos/layers/core/auth_service/auth_service.dart';
import 'package:apupu_eventos/layers/presenter/routes/Routes.dart';
import 'package:country_picker/country_picker.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({Key? key}) : super(key: key);

  @override
  State<PhoneNumberPage> createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  //final controller = AuthControllerFirebase.instance;
  final TextEditingController phoneController = TextEditingController();

  Country selectedCountry = Country(
      countryCode: 'AO',
      displayName: 'Angola',
      displayNameNoCountryCode: 'AO',
      e164Key: '',
      e164Sc: 0,
      example: 'Angola',
      geographic: true,
      level: 1,
      name: 'Angola',
      phoneCode: '244');

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(offset: phoneController.text.length),
    );
    return WillPopScope(
      onWillPop: () async {
        AuthService.error = "";
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 25,
              horizontal: 35,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset(
                      Utils.assetLogo,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Autenticação de Número Telefónico",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Adicione seu número de telefone. Enviaremos um código de verificação",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextFormField(
                    cursorColor: Colors.blueAccent,
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: "Digite o número de telefone",
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      prefixIcon: Container(
                        padding: const EdgeInsets.only(
                          top: 14.0,
                          left: 8.0,
                          right: 5.0,
                        ),
                        child: InkWell(
                          onTap: () {
                            showCountryPicker(
                                context: context,
                                countryListTheme: const CountryListThemeData(
                                  bottomSheetHeight: 400,
                                ),
                                onSelect: (value) {
                                  setState(() {
                                    selectedCountry = value;
                                  });
                                });
                          },
                          child: Text(
                            "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      child: const Text("Autenticar Número"),
                      onPressed: () async {
                        if (phoneController.text.isNotEmpty) {
                          final code = selectedCountry.phoneCode;
                          await AuthService.verifyNumber(
                              phoneNumber: "+$code${phoneController.text}",
                              next: () {
                                Navigator.pushNamed(
                                    context, Routes.CREATE_MANAGER);
                              });
                          AuthService.phone = phoneController.text;
                          Navigator.pushNamed(context, Routes.OTP);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Digite o número para continuar!"),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
