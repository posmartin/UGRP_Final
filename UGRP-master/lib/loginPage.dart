import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ugrp/data/user.dart';
import 'resultPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> with SingleTickerProviderStateMixin {
  FirebaseDatabase? _database;
  DatabaseReference? reference;
  String _databaseURL = 'https://ugrp-884ff-default-rtdb.firebaseio.com/';

  double opacity = 0;

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  // AnimationController? _animationController;
  // Animation? _animation;
  TextEditingController? _idTextController;
  TextEditingController? _pwTextController;

  String userEmail = '';
  String userPW = '';
  final _formKey = GlobalKey<FormState>();
  final _authentication = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    _idTextController = TextEditingController();
    _pwTextController = TextEditingController();

    // _animationController =
    //     AnimationController(duration: Duration(seconds: 3), vsync: this);
    // _animation =
    //     Tween<double>(begin: 0, end: pi * 2).animate(_animationController!);
    // _animationController!.repeat();
    // Timer(Duration(seconds: 2), () {
    //   setState(() {
    //     opacity = 1;
    //   });
    // });

    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database!.reference().child('user');
  }

  @override
  void dispose() {
    // _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {FocusScope.of(context).unfocus();},
        child: Scaffold(
            body: ListView(children: <Widget>[
          Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 100.h),
                  SizedBox(
                    height: 70.h,
                    child: Text(
                      'App title',
                      style: TextStyle(fontSize: 30.sp),
                    ),
                  ),

                  SizedBox(height: 100.h),
                  //AnimatedOpacity(
                  //opacity: opacity,
                  //duration: Duration(seconds: 0),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        width: 250.w,
                        height: 50.h,
                        child: TextFormField(
                          key: ValueKey(1),
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return '올바른 이메일 주소를 입력해주세요';
                            }
                          },
                          onSaved: (value) {
                            userEmail = value!;
                          },
                          onChanged: (value) {
                            userEmail = value;
                          },
                          controller: _idTextController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              labelText: 'Email', border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      SizedBox(
                        width: 250.w,
                        height: 50.h,
                        child: TextFormField(
                          key: ValueKey(2),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return '6자 이상 입력해주세요';
                            }
                          },
                          onSaved: (value) {
                            userPW = value!;
                          },
                          onChanged: (value) {
                            userPW = value;
                          },
                          controller: _pwTextController,
                          obscureText: true,
                          maxLines: 1,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(height: 50.h),
                      SizedBox(
                          width: 300.w,
                          height: 50.h,
                          child: ElevatedButton(
                              onPressed: (() async {
                                _tryValidation();
                                try {
                                  final newUser = await _authentication
                                      .signInWithEmailAndPassword(
                                          email: userEmail, password: userPW);

                                  /*FirebaseFirestore.instance.collection('user').doc(newUser.user!.uid)
                                  .set({
                                  });*/

                                  if (newUser.user != null) {
                                    Navigator.of(context).pushReplacementNamed(
                                        '/second',
                                        arguments: _idTextController!.value.text);
                                  }
                                } catch (e) {
                                  print(e);
                                  if (_formKey.currentState!.validate()) {
                                    makeDialog('이메일이 존재하지 않습니다.');
                                  } else {
                                    makeDialog('입력 형식을 확인해주세요');
                                  }
                                }
                              }),
                              child: Text('로그인',
                                  style: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.bold)),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                              ))),
                      SizedBox(height: 100.h),
                      SizedBox(height: 30.h, child: Text('회원이 아니신가요?')),
                      SizedBox(
                          width: 300.w,
                          height: 50.h,
                          child: ElevatedButton(
                              onPressed: (() {
                                Navigator.of(context).pushNamed('/sign');
                              }),
                              child: Text('회원가입',
                                  style: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.bold)),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.grey))),
                      /*Row(
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/sign');
                            },
                            child: Text('회원가입', style: TextStyle(fontSize: 15.sp)),
                          ),
                          SizedBox(width: 20.w),
                          TextButton(
                            onPressed: () {
                              if (_idTextController!.value.text.length == 0 ||
                                  _pwTextController!.value.text.length == 0) {
                                makeDialog('빈칸이 있습니다');
                              } else {
                                reference!
                                    .child(_idTextController!.value.text)
                                    .onValue
                                    .listen((event) {
                                  if (event.snapshot.value == null) {
                                    makeDialog('아이디가 없습니다');
                                  } else {
                                    reference!
                                        .child(_idTextController!.value.text)
                                        .onChildAdded
                                        .listen((event) {
                                      User user = User.fromSnapshot(event.snapshot);
                                      var bytes = utf8
                                          .encode(_pwTextController!.value.text);
                                      var digest = sha1.convert(bytes);
                                      if (user.pw == digest.toString()) {
                                        Navigator.of(context).pushNamed('/second',
                                            arguments:
                                                _idTextController!.value.text);
                                      } else {
                                        makeDialog('비밀번호가 틀립니다');
                                      }
                                    });
                                  }
                                });
                              }
                            },
                            child: Text('로그인',
                                style: TextStyle(
                                    color: Colors.redAccent, fontSize: 15.sp)),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),*/
                    ],
                  ),
                  //)
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),
          ),
        ])),
      ),
    );
  }

  void makeDialog(String text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(text),
          );
        });
  }
}
