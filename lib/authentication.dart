import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'dart:async';

import 'package:my_secretary/main_page.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => new _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  //facebook sign in
  final FacebookLogin facebookLogin = new FacebookLogin();

  //google sign in
  GoogleSignIn googleAuth = new GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return new Container(
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
          new MaterialButton(//Google Auth Button
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
            onPressed: () {
              googleAuth.signIn()
                  .then((result){
                    result.authentication.then((googleKey){
                      FirebaseAuth.instance.signInWithGoogle(
                        idToken: googleKey.idToken,
                        accessToken: googleKey.accessToken
                      ).then((signedInUser){
                        print('Signed in as ${signedInUser.displayName}');
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (BuildContext context) => MainPage()));
                      }).catchError((e){
                        print(e);
                      });
                    }).catchError((e){
                      print(e);
                    });
                  })
                  .catchError((e){
                    print(e);
                  });
            },
          ),//MaterialButton;
          new Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),//Padding
          new MaterialButton(
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
          ),//MaterialButton
        ],//<Widget>[]
      ),//Column
    );//container
  }
}
