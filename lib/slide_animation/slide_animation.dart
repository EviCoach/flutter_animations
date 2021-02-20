import 'package:animations_coach/slide_animation/offset_delay.dart';
import 'package:flutter/material.dart';

class SlideAnimation extends StatefulWidget {
  @override
  _SlideAnimationState createState() => _SlideAnimationState();
}

class _SlideAnimationState extends State<SlideAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Slide Animation"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => OffsetDelay(),
            ));
          },
          color: Theme.of(context).primaryColor,
          child: Text(
            "Offset & Delay Animation",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
