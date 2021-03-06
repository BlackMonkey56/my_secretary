import 'package:flutter/material.dart';
import 'package:my_secretary/todo_list.dart';
import 'package:my_secretary/weather_info.dart';

class TodoListPanel extends StatefulWidget {

  final AnimationController controller;

  TodoListPanel({this.controller});

  @override
  _TodoListPanelState createState() => new _TodoListPanelState();
}

class _TodoListPanelState extends State<TodoListPanel> {
  static const header_height = 32.0;

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints){
    final height = constraints.biggest.height;
    final backPanelHeight = height - header_height;
    final frontPanelHeight = -header_height;

    return new RelativeRectTween(
      begin: new RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
      end: new RelativeRect.fromLTRB(0.0, backPanelHeight, 0.0, frontPanelHeight),
    ).animate(new CurvedAnimation(parent: widget.controller, curve: Curves.linear));
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints){

    final ThemeData theme = Theme.of(context);

    return new Container(
      child: new Stack(
        children: <Widget>[
          //뒷 패널 부분(날씨정보 안내)을 구성하는 부분
          new Container(
            color: Color.fromRGBO(25,44,60,1.0),
            child: new Center(
                child: new WeatherInfoBoard(),
            ),
          ),
          //앞 패널 부분을 구성하는 부분(하단 아래쪽에 숨겨져 있으며 상단 바의 리스트 아이콘을 클릭 시 패널이 올라옴)
          //체크리스트
          new PositionedTransition(
              rect: getPanelAnimation(constraints),
              child: new Material(
                color: Color.fromRGBO(59,134,131,1.0),
                elevation: 12.0,
                borderRadius: new BorderRadius.only(
                  topLeft: new Radius.circular(16.0),
                  topRight: new Radius.circular(16.0),
                ),
                child: new Column(
                  children: <Widget>[
                    new Container(
                      height: header_height,
                      child: new Center(
                        child: new Text("To Do List", style: new TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w900, color: Color.fromRGBO(232,181,79,1.0)
                          ),
                        ),
                      ),
                    ),
                    new Expanded(
                        child: new TodoList(),
                    )
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(builder: bothPanels);
  }
}
