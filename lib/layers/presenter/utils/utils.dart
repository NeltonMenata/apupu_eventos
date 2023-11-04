import 'dart:io';
import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static const assetLogo = "assets/logo/logo.png";

  static capture(GlobalKey? key, BuildContext context,
      [String? contact, bool w = false]) async {
    //variavel W serve para habilitar o botão whatsapp no compartilhamento!
    try {
      if (key == null) return;
      final renderObject =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary?;
      if (renderObject == null) return;
      final render = await renderObject.toImage(pixelRatio: 2);
      final byData = await render.toByteData(format: ImageByteFormat.png);
      if (byData == null) return;
      final buffer8 = byData.buffer.asUint8List();
      final dir = await path.getExternalStorageDirectories(
          type: path.StorageDirectory.pictures);
      final math = Random().nextInt(1000);
      final name = "imagem$math"; //DateTime.now().toIso8601String();

      if (dir == null) return;
      final file = File("${dir.first.path}/$name.jpg");
      file.writeAsBytesSync(buffer8);

      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Image.file(file),
              actions: [
                !w
                    ? const SizedBox()
                    : TextButton(
                        onPressed: () async {
                          try {
                            final saveFile = ParseFile(file);
                            final result = await saveFile.save();
                            if (result.success) {
                              final uri = Uri.parse(
                                  "https://wa.me/244$contact/?text=${saveFile.url} \n\nNão compartilhe este link, use para baixar o seu QrCode!");
                              await launchUrl(uri,
                                  mode: LaunchMode.externalApplication);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Erro: ${result.error}"),
                                backgroundColor: Colors.red,
                              ));
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Erro: $e"),
                              backgroundColor: Colors.red,
                            ));
                          }
                        },
                        child: const Text("Whatsapp")),
                TextButton(
                    onPressed: () async {
                      //Share.shareFiles(['/image.jpg'], text: 'Great picture');
                      // ignore: deprecated_member_use
                      await Share.shareFiles([file.path],
                          mimeTypes: ["image/jpg"], text: "Meu Código");
                    },
                    child: const Text("Compartilhar")),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Sair"),
                )
              ],
            );
          });
      await file.delete();
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Error qrcode: $e"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Sair"))
              ],
            );
          });
    }
  }
}

String reverse(String value) {
  var valueReverse = "";
  var valueLength = value.length - 1;
  for (var index = 0; index < value.length; index++) {
    valueReverse += value[valueLength];
    valueLength--;
  }

  return valueReverse;
}

String separatorMoney(String valueMain, [String unitSep = "."]) {
  var value = reverse(valueMain);
  List<String> orderIndex = [];
  var newValue = "";
  for (int index = 0; index < value.length + 1; index++) {
    orderIndex.add("");
  }
  for (var index = 0; index < value.length; index++) {
    orderIndex[index + 1] = value[index];
  }

  for (var index = 1; index < orderIndex.length; index++) {
    if (index % 3 == 0 && orderIndex.length > 4) {
      if ((index + 1) == orderIndex.length) {
        newValue += orderIndex[index];
      } else {
        newValue += orderIndex[index] + unitSep;
      }
    } else {
      newValue += orderIndex[index];
    }
  }

  return reverse(newValue);
}

String separator(String value) {
  if (value.length > 3) {
    String newValue = "";

    for (int letter = 0; letter < value.length; letter++) {
      if (letter == 0 && value.length == 4 ||
          letter == 0 && value.length == 7) {
        newValue = newValue + value[letter] + ".";
      } else if (letter == 2 && value.length == 5) {
        newValue = newValue + "." + value[letter];
      } else if (letter == 3 && value.length == 6) {
        newValue = newValue + "." + value[letter];
      } else if (letter == 4 && value.length == 7) {
        newValue = newValue + "." + value[letter];
      } else {
        newValue = newValue + value[letter];
      }
    }
    return newValue;
  }
  return value;
}

Future<void> showResultCustom(BuildContext context, String valueResult,
    {bool isError = false, Color? color, Function? action}) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: isError ? Colors.red : color,
        content: Text(
          valueResult,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color != null
                ? Colors.white
                : isError
                    ? Colors.white
                    : Colors.black,
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              "Ok",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color != null
                    ? Colors.white
                    : isError
                        ? Colors.white
                        : Colors.black,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              if (action != null) {
                action();
              }
            },
          )
        ],
      );
    },
  );
}
