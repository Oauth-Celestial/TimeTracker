import 'package:flutter/cupertino.dart';

class FloatingWidget extends StatefulWidget {
  int? translateY;
  Duration? animationDuration;
  Widget child;
  FloatingWidget(
      {this.translateY, this.animationDuration, required this.child});

  @override
  State<FloatingWidget> createState() => _FloatingWidgetState();
}

class _FloatingWidgetState extends State<FloatingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: widget.animationDuration == null
            ? Duration(seconds: 2)
            : widget.animationDuration);
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController.view,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
              _animationController.value,
              _animationController.value *
                  (widget.translateY == null ? 5 : widget.translateY!)),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
