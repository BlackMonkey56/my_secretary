import 'package:flutter/material.dart';
import 'package:my_secretary/authentication.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => new _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Container(
            decoration: BoxDecoration(color: Colors.deepOrange),
          ),//Container
          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                flex: 2,
                child: new Container(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 70.0,
                        child: new Icon(
                          Icons.directions_run,
                          color: Colors.redAccent,
                          size: 90.0,
                        ),//Icon
                      ),//CircleAvatar
                      new Padding(
                          padding: EdgeInsets.only(top: 10.0)
                      ),//Padding
                      new Text(
                        "My Secretary",
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold
                        ),//TextStyle
                      ),//Text
                    ],//<Widget>[]
                  ),//Column
                ),//Container
              ),//Expanded
              new Expanded(
                flex: 1,
                child: new Container(
                  child: new Authentication(),
                ),//Container
              ),//Expanded
            ],//<Widget>[]
          ),//Column
        ],//<Widget>[]
      ),//Stack
    );//Scaffold
  }
}
