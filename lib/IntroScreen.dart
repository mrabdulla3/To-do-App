import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/main.dart';

class IntroScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_MyIntroScreenState();

}
class _MyIntroScreenState extends State<IntroScreen>{
  @override
  void initState() {
    Timer(Duration(seconds: 3),() {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => MyHomePage(title: '',),));
    } );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.purpleAccent.shade200,
          child: Image.asset('assets/Images/icon.png'),
        ),
      ),

    );
  }
  
}