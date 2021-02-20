import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  AnimationController _controller;
  Animation<Size> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    _animation = Tween<Size>(begin: Size(200, 44), end: Size(200, 330))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear))
          ..addListener(listener);
  }

  void listener() => setState(() {});

  void _incrementCounter() {
    setState(() {
      _currentIndex++;
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Container(
          height:
              _currentIndex == 0 ? 44 : _animation.value.height.roundToDouble(),
          width: 100,
          color: Colors.blue,
          child: Center(
            child: Text("$_currentIndex"),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
