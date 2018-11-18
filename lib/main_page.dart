import 'package:flutter/material.dart';

import 'package:my_secretary/todo_list_panel.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin{
  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 100), value: 1.0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  bool get isPanelVisible{
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed || status == AnimationStatus.forward;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("MainPage"),
        elevation: 0.0,
        leading: new IconButton(
            icon: new AnimatedIcon(
                icon: AnimatedIcons.view_list,
                progress: controller.view,
            ),//AnimatedIcon
            onPressed: (){
              controller.fling(velocity: isPanelVisible ? -1.0 : 1.0);
            },
        ),//IconButton

      ),//AppBar
      body: new TodoListPanel(
          controller: controller,
      ),//TodoListPanel
    );
  }
}
