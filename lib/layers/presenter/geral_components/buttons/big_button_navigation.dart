import 'package:flutter/material.dart';

class BigButtonNavigation extends StatelessWidget {
  const BigButtonNavigation(
      {required this.title,
      required this.icon,
      required this.action,
      this.bgColor,
      this.color,
      Key? key})
      : super(key: key);
  final String title;
  final IconData icon;
  final MaterialStateProperty<Color>? bgColor;
  final Color? color;
  final Function action;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final allPaddingContainer = width * .015;

    return Padding(
      padding: EdgeInsets.all(allPaddingContainer),
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
            backgroundColor:
                bgColor ?? MaterialStateProperty.all<Color>(Colors.black87)),
        onPressed: () {
          action();
        },
        child: Container(
          padding: EdgeInsets.only(
              top: allPaddingContainer, right: allPaddingContainer),
          width: double.infinity, //width * .35,
          height: height * .15,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon, size: width * .13, color: color),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * .03),
                  child: Text(
                    title,
                    style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: width * .05),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
