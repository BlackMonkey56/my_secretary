import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_secretary/intro_page.dart';
import 'package:my_secretary/main_page.dart';

void main() => runApp(MaterialApp(
  theme:
    ThemeData(primaryColor: Colors.deepOrange, accentColor: Colors.deepOrangeAccent),
  debugShowCheckedModeBanner: false,
  //home: (FirebaseAuth.instance.currentUser() != null) ? new MainPage() : new IntroPage(),
  home: new IntroPage(),
));