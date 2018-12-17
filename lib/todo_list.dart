import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'services/crud.dart';
import 'dart:async';

//체크리스트를 구체적으로 구현하는 코드

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => new _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final todoTextController = new TextEditingController();
  final optionTextController = new TextEditingController();

  String todoStr = "";
  String optionStr = "";

  Stream todos;

  CRUDmethods crudObj = new CRUDmethods();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Firestore에 저장된 데이터 불러오기
    crudObj.getData().then((results){
      setState(() {
        todos = results;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            height: 200.0,
            child: new Padding(
              padding: EdgeInsets.only(
                left: 30.0,
                right: 30.0,
              ),//EdgeInsets.only
              child: new Column(
                children: <Widget>[
                  // 입력부분
                  new TextField(
                    decoration: new InputDecoration(
                      labelStyle: Theme.of(context).textTheme.display1,
                      labelText: '할 일',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),//InputDecoration
                    onChanged: (value){
                      this.todoStr = value;
                    },
                    controller: todoTextController,
                  ),//TextField,
                  new Padding(
                    padding: EdgeInsets.all(5.0),
                  ),//Padding
                  new TextField(
                    decoration: new InputDecoration(
                      labelStyle: Theme.of(context).textTheme.display1,
                      labelText: '옵션(장소, 시간...)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (value){
                      this.optionStr = value;
                    },
                    controller: optionTextController,
                  ),
                  new Padding(
                    padding: EdgeInsets.all(5.0),
                  ),//Padding
                  //등록 버튼
                  new RaisedButton(
                    child: new Text(
                      '등 록',
                      style: new TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Color.fromRGBO(232,180,70,1.0),
                          fontSize: 18.0,
                      ),
                    ),
                    color: Color.fromRGBO(25,45,62,1.0),
                    onPressed: () {
                      if(todoTextController.text.isNotEmpty){
                        Map<String, dynamic> todoData = {
                          'todo' : this.todoStr,
                          'option' : this.optionStr,
                          'isComplete' : false,
                        };

                        crudObj.addData(todoData).whenComplete((){
                          crudObj.getData().then((results){
                            setState(() {
                              todos = results;
                            });
                          });

                          //등록 완료된 후에 TextField 초기화
                          this.todoStr = "";
                          this.optionStr = "";
                          todoTextController.text = "";
                          optionTextController.text = "";
                        }).catchError((e){
                          print(e);
                        });
                      }
                    },
                  ),//RaisedButton
                ],//<Widgets>[]
              ),//Column
            ),//Padding
          ),//Expanded
          //작성된 리스트를 보여주기 위해 리스트 항목들을 각각 만들어내는 부분
          //구글의 firebase로 부터 읽어 들인 데이터들을 기반으로 리스트 항목을 구성함
          new Expanded(
            flex: 3,
            child: new StreamBuilder(
              stream: todos,
              builder: (context, snapshot){
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  padding: EdgeInsets.all(5.0),
                  itemBuilder: (context, i) {
                    return new Slidable(
                      delegate: new SlidableDrawerDelegate(),
                      actionExtentRatio: 0.25,
                      child: new Container(
                        child: new ListTile(
                          title: Text(
                            snapshot.data.documents[i].data['todo'],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 20.0
                            ),
                          ),
                          subtitle: Text(
                            snapshot.data.documents[i].data['option'],
                            style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontSize: 12.0
                            ),
                          ),
                          leading: new Checkbox(
                            onChanged: (bool check) {
                              setState(() {
                                crudObj.updateData(snapshot.data.documents[i].documentID, {
                                  'isComplete': check
                                });
                              });
                            },
                            value: snapshot.data.documents[i].data['isComplete'],
                            activeColor: Color.fromRGBO(220,95,70,1.0),
                          ),
                        ),//ListTile
                      ),//Container
                      //리스트 항목을 왼쪽으로 슬라이드 했을 때 항목 삭제 버튼을 구성
                      secondaryActions: <Widget>[
                        new IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () => deleteDialog(context).then((value){
                            if(value){
                              crudObj.deleteData(snapshot.data.documents[i].documentID);
                            }
                          }),
                        ),//IconSlideAction
                      ],//<Widget>[]
                    ); //Slidable
                  },
                );//ListView.builder
              },
            ),//StreamBuilder
          ),//Expanded
        ],
      ),//Column
    );//Container
  }
}

Future<bool> deleteDialog(BuildContext context){
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return new AlertDialog(
        title: new Text("항목을 삭제 하시겠습니까?"),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: new Text("네"),
          ),//FlatButton
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: new Text("아니요"),
          ),//FlatButton
        ],
      );//AlertDialog
    },
  );//showDialog
}