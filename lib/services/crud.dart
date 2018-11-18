import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'dart:async';

class CRUDmethods{

  FirebaseUser _user;

  bool isLoggedIn(){
    if(FirebaseAuth.instance.currentUser() != null){
      return true;
    }else{
      return false;
    }
  }

  Future<void> addData(todoData) async{

    if(isLoggedIn()){
      Firestore.instance.runTransaction((Transaction crudTransaction) async{
        CollectionReference reference = await Firestore.instance.collection("ToDoList");

        reference.add(todoData);
      });
    }else{
      print("You aren't logged in");
    }
  }

  getData() async{
    return await Firestore.instance.collection('ToDoList').snapshots();
  }

  updateData(docId, newValues){
    Firestore.instance
        .collection('ToDoList')
      .document(docId)
      .updateData(newValues)
      .catchError((e){
        print(e);
      });
  }

  deleteData(docId){
    Firestore.instance
        .collection('ToDoList')
        .document(docId)
        .delete()
        .catchError((e){
          print(e);
        });
  }
}