import 'package:flutter/material.dart';

class FifthPage extends StatefulWidget{
  @override
  State<FifthPage> createState() => _FifthPageState();
}

class _FifthPageState extends State<FifthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(child: Text('go to main page'), onPressed: ( () {Navigator.of(context).pushReplacementNamed('/second');}),),
          ElevatedButton(child: Text('go to result page'), onPressed: ( () {Navigator.of(context).pushReplacementNamed('/seventh');}))
        ],
      ),
    );
  }
}