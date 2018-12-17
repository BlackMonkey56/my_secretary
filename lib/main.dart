import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_secretary/intro_page.dart';
import 'package:my_secretary/main_page.dart';

//코드의 메인 실행부분
void main() => runApp(MaterialApp(
  theme:
    ThemeData(primaryColor: Color.fromRGBO(220,95,70,1.0), accentColor: Colors.deepOrangeAccent),
  debugShowCheckedModeBanner: false,
  //home: (FirebaseAuth.instance.currentUser() != null) ? new MainPage() : new IntroPage(),
  //구글 인증과 페이스북 인증을 하는 페이지를 호출
  home: new IntroPage(),
));