import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AnimatedDrawer extends StatefulWidget {
  Color? color;
  AnimatedDrawer({this.color});

  @override
  State<AnimatedDrawer> createState() => _AnimatedDrawerState();
}

class _AnimatedDrawerState extends State<AnimatedDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: widget.color ?? Colors.white,
        width: 260,
        height: double.infinity,
      ),
    );
  }
}
