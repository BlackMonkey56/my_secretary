import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

import 'package:my_secretary/main_page.dart';

class MyGoogleAuth extends StatefulWidget {
  MyGoogleAuth({Key key}) : super(key: key);
  @override
  _MyGoogleAuthState createState() => new _MyGoogleAuthState();
}

class _MyGoogleAuthState extends State<MyGoogleAuth> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn() async{
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: gSA.idToken, accessToken: gSA.accessToken);

    print("User Name : ${user.displayName}");
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialButton(
      height: 50.0,
      minWidth: 180.0,
      color: Colors.red,
      child: new Text(
        "Google",
        style: new TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold
        ),//TextStyle
      ),//Text
      onPressed: () => _signIn()
        .whenComplete((){
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (BuildContext context) => MainPage()));
        })
        .catchError((err)=>print(err)),
    );//MaterialButton;
  }
}
