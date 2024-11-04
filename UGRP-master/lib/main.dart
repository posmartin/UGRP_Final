import 'package:flutter/material.dart';
import 'cameraPage.dart';
import 'loginPage.dart';
import 'package:ugrp/signUpPage.dart';
import 'mainPage.dart';
import 'choicePage.dart';
import 'resultPage.dart';
import 'fourthPage.dart';
import 'fifthPage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import '../component/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(392.7, 737.4), //숫자 뒤에 .w, .h, .sp 를 쓰면 designSize 기준 가로, 세로, 폰트 크기가 된다.
      builder: (_, child) => MaterialApp(
        title: 'app title',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/sign': (context) => SignPage(),
          '/second': (context) => SecondPage(0, 0),
          '/third': (context) => ThirdPage(),
          /*'/lunge': (context) => LungeExplain(),
          '/side' : (context) => SidePlankExplain(),
          '/squat': (context) => SquatExplain(),*/
          '/fifth': (context) => FifthPage(),
          '/seventh': (context) => SeventhPage(),
        },
      ),
    );
  }
}

