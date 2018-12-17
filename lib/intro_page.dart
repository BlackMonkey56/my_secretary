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
            decoration: BoxDecoration(color: Color.fromRGBO(25,44,60,1.0)),
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
                      //상위 앱의 아이콘과 타이틀을 표기한 부분
                      new CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 70.0,
                        child: new Icon(
                          Icons.directions_run,
                          color: Color.fromRGBO(25,44,60,1.0),
                          size: 90.0,
                        ),//Icon
                      ),//CircleAvatar
                      new Padding(
                          padding: EdgeInsets.only(top: 10.0)
                      ),
                      new Text(
                        "My Secretary",
                        style: new TextStyle(
                          color: Colors.redAccent[400],
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold
                        ),//TextStyle
                      ),//Text
                    ],//<Widget>[]
                  ),//Column
                ),//Container
              ),//Expanded
              //구글과 페이스북 인증을 실행하기 위해 인증 구현 코드를 호출
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
