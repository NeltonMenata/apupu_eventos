import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:share_plus/share_plus.dart';

class Utils {
  static const assetLogo = "assets/logo/logo.png";

  static capture(GlobalKey? key, BuildContext context) async {
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
      final name = DateTime.now().toString();
      if (dir == null) return;
      final file = File("${dir.first.path}/$name.png");
      file.writeAsBytesSync(buffer8);

      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Image.file(file),
              actions: [
                TextButton(
                    onPressed: () async {
                      //Share.shareFiles(['/image.jpg'], text: 'Great picture');
                      // ignore: deprecated_member_use
                      await Share.shareFiles([file.path],
                          mimeTypes: ["image/png"], text: "Meu Código");
                      //file.delete();
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
      file.delete();
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

String separatorMoney(String value) {
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
