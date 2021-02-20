import 'package:flutter/material.dart';

class ImplicitAnimation extends StatefulWidget {
  @override
  _ImplicitAnimationState createState() => _ImplicitAnimationState();
}

class _ImplicitAnimationState extends State<ImplicitAnimation>
    with SingleTickerProviderStateMixin {
  Animation<Size> _animation;
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<Size>(
      begin: Size(44, 200),
      end: Size(22, 300),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    )..addListener(listener);
  }

  void listener() => setState(() {});

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        // builder decides what to re-render when the state changes
        builder: (ctx, child) => Container(
              height: _animation.value.height,
              width: 44,
            ));
  }
}
