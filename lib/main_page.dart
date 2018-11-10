import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("MainPage"),
      ),
      body: new Container(
        color: Colors.blue,
        child: new Center(
          child: new Text("Make anything here"),
        ),
      ),
    );
  }
}
