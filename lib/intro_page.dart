import 'package:flutter/material.dart';
import 'package:my_secretary/google_auth.dart';
import 'package:my_secretary/facebook_auth.dart';

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
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                          "-  -  -  -  -  Sign with  -  -  -  -  -",
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                        ),//TextStyle
                      ),//Text
                      new Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),//Padding
                      new MyGoogleAuth(),
                      new Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),//Padding
                      new MyFacebookAuth(),
                    ],//<Widget>[]
                  ),//Column
                ),//Container
              ),//Expanded
            ],//<Widget>[]
          ),//Column
        ],//<Widget>[]
      ),//Stack
    );//Scaffold
  }
}
