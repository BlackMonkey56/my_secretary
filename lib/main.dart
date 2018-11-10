import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'intro_page.dart';

void main() => runApp(MaterialApp(
  theme:
    ThemeData(primaryColor: Colors.deepOrange, accentColor: Colors.deepOrangeAccent),
  debugShowCheckedModeBanner: false,
  home: new IntroPage(),
));