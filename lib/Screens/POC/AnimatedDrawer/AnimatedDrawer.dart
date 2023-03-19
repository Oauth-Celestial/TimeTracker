import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:timetracker/Services/Theme/ColorConstant.dart';

class AnimatedDrawer extends StatefulWidget {
  Widget? drawerWiget;
  Widget? baseWidget;

  AnimatedDrawer({this.drawerWiget, this.baseWidget});

  @override
  State<AnimatedDrawer> createState() => _AnimatedDrawerState();
}

class _AnimatedDrawerState extends State<AnimatedDrawer>
    with SingleTickerProviderStateMixin {
  bool isDrawerOpen = false;
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> scaleanimation;

  @override
  void initState() {
    // TODO: implement initState
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..addListener(() {
            setState(() {});
          });
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
    scaleanimation = Tween<double>(begin: 1, end: 0.9).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
              curve: Curves.fastOutSlowIn,
              duration: Duration(milliseconds: 200),
              left: isDrawerOpen ? 0 : -260,
              width: 260,
              height: MediaQuery.of(context).size.height,
              child: widget.drawerWiget ?? Container()),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(animation.value - 30 * animation.value * pi / 180),
            child: Transform.translate(
              offset: Offset(animation.value * 260, 0),
              child: Transform.scale(
                scale: scaleanimation.value,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: widget.baseWidget ?? Container(),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            left: isDrawerOpen ? 200 : 10,
            top: 20,
            child: InkWell(
              onTap: () {
                if (isDrawerOpen) {
                  animationController.reverse();
                } else {
                  animationController.forward();
                }
                setState(() {
                  isDrawerOpen = !isDrawerOpen;
                });
              },
              child: ClipOval(
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.transparent,
                  child: isDrawerOpen
                      ? Icon(
                          Icons.close,
                          color: Colors.amber,
                        )
                      : Icon(
                          Icons.menu,
                          color: whiteText,
                        ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
