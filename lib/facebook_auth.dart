import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'main_page.dart';

class MyFacebookAuth extends StatefulWidget {
  @override
  _MyFacebookAuthState createState() => new _MyFacebookAuthState();
}

class _MyFacebookAuthState extends State<MyFacebookAuth> {
  
  final FacebookLogin facebookLogin = new FacebookLogin();

  @override
  Widget build(BuildContext context) {
    return new MaterialButton(
      height: 50.0,
      minWidth: 180.0,
      color: Colors.blue[800],
      child: new Text(
        "Facebook",
        style: new TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold
        ),//TextStyle
      ),//Text
      onPressed: (){
        facebookLogin.logInWithReadPermissions(['email', 'public_profile'])
            .then((result){
              switch(result.status){
                case FacebookLoginStatus.loggedIn:
                  FirebaseAuth.instance.signInWithFacebook(
                      accessToken: result.accessToken.token
                  ).whenComplete((){
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (BuildContext context) => MainPage()));
                  }).catchError((err)=>print(err));
                  break;
                case FacebookLoginStatus.cancelledByUser:
                  break;
                case FacebookLoginStatus.error:
                  break;
              }
            })
            .catchError((err)=>print(err));
      },
    );//MaterialButton
  }
}
