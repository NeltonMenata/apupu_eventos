import 'dart:math';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FloatingButtonMenu extends StatefulWidget {
  FloatingButtonMenu(
      {Key? key,
      this.onPressed1,
      this.onPressed2,
      this.onPressed3,
      this.onPressed4})
      : super(key: key);

  Function? onPressed1;
  Function? onPressed2;
  Function? onPressed3;
  Function? onPressed4;

  @override
  State<FloatingButtonMenu> createState() => _FloatingButtonMenuState();
}

const buttonSize = 50.0;

class _FloatingButtonMenuState extends State<FloatingButtonMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 250), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final iconSize = 30.0;
  @override
  Widget build(BuildContext context) {
    return Flow(delegate: FlowDelegateMenu(controller: controller), children: [
      SizedBox(
        width: buttonSize,
        height: buttonSize,
        child: FloatingActionButton(
          heroTag: "fab1",
          onPressed: () {
            if (controller.status == AnimationStatus.completed) {
              controller.reverse();
            } else {
              controller.forward();
            }
            widget.onPressed4!();
          },
          child: Icon(
            Icons.qr_code_scanner_sharp,
            color: Colors.white,
            size: iconSize,
          ),
          elevation: 0,
          splashColor: Colors.black,
        ),
      ),
      SizedBox(
        width: buttonSize,
        height: buttonSize,
        child: FloatingActionButton(
          heroTag: "fab2",
          onPressed: () {
            if (controller.status == AnimationStatus.completed) {
              controller.reverse();
            } else {
              controller.forward();
            }
            widget.onPressed3!();
          },
          child: Icon(
            Icons.share_outlined,
            color: Colors.white,
            size: iconSize,
          ),
          elevation: 0,
          splashColor: Colors.black,
        ),
      ),
      SizedBox(
        width: buttonSize,
        height: buttonSize,
        child: FloatingActionButton(
          heroTag: "fab3",
          onPressed: () {
            if (controller.status == AnimationStatus.completed) {
              controller.reverse();
            } else {
              controller.forward();
            }
            widget.onPressed2!();
          },
          child: Icon(
            Icons.group_add_sharp,
            color: Colors.white,
            size: iconSize,
          ),
          elevation: 0,
          splashColor: Colors.black,
        ),
      ),
      SizedBox(
        width: buttonSize,
        height: buttonSize,
        child: FloatingActionButton(
          heroTag: "fab4",
          onPressed: () {
            if (controller.status == AnimationStatus.completed) {
              controller.reverse();
            } else {
              controller.forward();
            }
            widget.onPressed1!();
          },
          child: Icon(
            Icons.search_sharp,
            color: Colors.white,
            size: iconSize,
          ),
          elevation: 0,
          splashColor: Colors.black,
        ),
      ),
      SizedBox(
        width: buttonSize,
        height: buttonSize,
        child: FloatingActionButton(
          heroTag: "fab5",
          onPressed: () {
            if (controller.status == AnimationStatus.completed) {
              controller.reverse();
            } else {
              controller.forward();
            }
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: iconSize,
          ),
          elevation: 0,
          splashColor: Colors.black,
        ),
      ),
    ]);
  }

  Widget buildFAB(IconData icon, Function? pressed) {
    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: FloatingActionButton(
        onPressed: () {
          if (controller.status == AnimationStatus.completed) {
            controller.reverse();
          } else {
            controller.forward();
          }
        },
        child: Icon(
          icon,
          color: Colors.white,
          size: 40,
        ),
        elevation: 0,
        splashColor: Colors.black,
      ),
    );
  }
}

class FlowDelegateMenu extends FlowDelegate {
  final Animation<double> controller;
  const FlowDelegateMenu({required this.controller})
      : super(repaint: controller);

  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    final xStart = size.width - buttonSize;
    final yStart = size.height - buttonSize;

    final n = context.childCount;
    for (int i = 0; i < n; i++) {
      final isLastItem = i == context.childCount - 1;
      dynamic setValue(value) => isLastItem ? 0.0 : value;

      final radius = 180 * controller.value;
      final theta = i * pi * 0.5 / (n - 2);
      final x = xStart - setValue(radius * cos(theta));
      final y = yStart - setValue(radius * sin(theta));
      context.paintChild(i,
          transform: Matrix4.identity()
            ..translate(x, y, 0)
            ..translate(buttonSize / 2, buttonSize / 2)
            ..rotateZ(180 * (1 - controller.value) * pi / 180)
            ..scale(isLastItem ? 1.0 : max(controller.value, 0.5))
            ..translate(-buttonSize / 2, -buttonSize / 2));
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false;
  }
}
