import 'package:flutter/material.dart';

class OffsetDelay extends StatefulWidget {
  @override
  _OffsetDelayState createState() => _OffsetDelayState();
}

class _OffsetDelayState extends State<OffsetDelay>
    with SingleTickerProviderStateMixin {
  // this will take the value that will change overtime
  // it takes the beginning value and the ending value
  // it just changes value from beginning to the end.
  // it is not aware of any widget on the screen
  Animation _animation;
  Animation lateAnimation;

  // this use to control the animation object
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    )
      ..addListener(listener)
      ..addStatusListener(statusListener);

    lateAnimation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.2,
          1.0,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    _controller.forward();
  }

  void statusListener(status) {
    print('animation running');
    if (status == AnimationStatus.completed) {
      _controller.reset(); // so we can set new values to the animation
      _animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.fastOutSlowIn,
        ),
      );
      lateAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.2,
            1.0,
            curve: Curves.fastOutSlowIn,
          ),
        ),
      )..addStatusListener(lateStatusListener);
      _controller.forward();
    }
  }

  void lateStatusListener(status) {
    if (status == AnimationStatus.completed) {
      _controller.stop();
      _animation.removeListener(listener);
      _animation.removeStatusListener(statusListener);
      lateAnimation.removeListener(listener);
      lateAnimation.removeStatusListener(lateStatusListener);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void listener() => setState(() {});

  Widget _buildContainer() => Container(
        height: 20.0,
        width: 120.0,
        color: Theme.of(context).primaryColor,
        margin: EdgeInsets.only(bottom: 2),
      );

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Offset And Delay Animation"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform(
              child: _buildContainer(),
              transform: Matrix4.translationValues(
                  _animation.value * deviceWidth, 0.0, 0.0),
            ),
            Transform(
              child: _buildContainer(),
              transform: Matrix4.translationValues(
                  _animation.value * deviceWidth, 0.0, 0.0),
            ),
            Transform(
              child: _buildContainer(),
              transform: Matrix4.translationValues(
                  lateAnimation.value * deviceWidth, 0.0, 0.0),
            ),
          ],
        ),
      ),
    );
  }
}
