import 'package:flutter/material.dart';

class ScaffoldGeneral extends StatefulWidget {
  ScaffoldGeneral({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.body,
    this.paddingTop,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Widget body;

  final double? paddingTop;

  @override
  State<ScaffoldGeneral> createState() => _ScaffoldGeneralState();
}

class _ScaffoldGeneralState extends State<ScaffoldGeneral> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    const paddingLeft = 15.0;
    final paddingTop = widget.paddingTop ?? height * 0.1;
    const paddingBottom = 8.0;
    final fontSizeTitle = width * .086;
    final fontSizeSubtitle = width * .049;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: paddingLeft, top: paddingTop, bottom: paddingBottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: fontSizeTitle),
                ),
                //SizedBox(height: paddingBottom),
                Text(
                  widget.subtitle,
                  style: TextStyle(fontSize: fontSizeSubtitle),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 8.0, left: 8.0, right: 8.0, bottom: 50.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  border: Border.all(
                    width: 1.5,
                  ),
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.black, Colors.blue]),
                  borderRadius: BorderRadius.circular(15)),
              alignment: Alignment.topCenter,
              child: widget.body,
            ),
          ),
        ],
      ),
    );
  }
}
