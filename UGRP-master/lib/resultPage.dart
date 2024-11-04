import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'cameraPage.dart';
import 'mainPage.dart';

class SeventhPage extends StatefulWidget {
  @override
  State<SeventhPage> createState() => _SeventhPage();
}


class _SeventhPage extends State<SeventhPage> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  late int mytime;
  late int mykcal;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void setData(){
    mytime = 3; //실제로는 camerapage로부터 data 받기
    mykcal = 5;
    print('mytime, mykcal 설정 완료');
  }

  @override
  Widget build(BuildContext context) {
    /*FirebaseFirestore.instance
        .collection('user')
        .doc(loggedUser!.uid)
        .collection('calendar')
        .doc(DateFormat("yyyy-MM-dd").format(DateTime.now()))
        .set({'kcal': lastkcal, 'time': lasttime});
    print('업로드 완료');*/
    setData();
    //final infor = ModalRoute.of(context)!.settings.arguments as Information;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100.h),
            SizedBox(
                height: 55.h,
                child: Text('축하합니다!!',
                    style: TextStyle(
                        fontSize: 40.sp, fontWeight: FontWeight.bold))),
            SizedBox(height: 20.h),
            SizedBox(
                child: Text(
                  '목표를 달성했습니다!',
                  style: TextStyle(fontSize: 15.sp),
                )),
            SizedBox(height: 20.h),
            SizedBox(child: Text('?? 일 연속 운동 중')),
            SizedBox(height: 20.h),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      border: Border(
                          left: BorderSide(color: Colors.black, width: 2.0),
                          top: BorderSide(color: Colors.black, width: 2.0),
                          right: BorderSide(color: Colors.black, width: 1.0))),
                  width: 150.w,
                  height: 35.h,
                  alignment: Alignment.center,
                  child: Text('소모 칼로리')),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      border: Border(
                          top: BorderSide(color: Colors.black, width: 2.0),
                          right: BorderSide(color: Colors.black, width: 2.0))),
                  width: 150.w,
                  height: 35.h,
                  alignment: Alignment.center,
                  child: Text('소요 시간', textAlign: TextAlign.center)),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          left: BorderSide(color: Colors.black, width: 2.0),
                          bottom: BorderSide(color: Colors.black, width: 2.0),
                          top: BorderSide(color: Colors.black, width: 1.0),
                          right: BorderSide(color: Colors.black, width: 1.0))),
                  width: 150.w,
                  height: 35.h,
                  alignment: Alignment.center,
                  child: Text('${mykcal} kcal')),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(color: Colors.black, width: 2.0),
                          right: BorderSide(color: Colors.black, width: 2.0),
                          top: BorderSide(color: Colors.black, width: 1.0))),
                  width: 150.w,
                  height: 35.h,
                  alignment: Alignment.center,
                  child: Text('${mytime} 분')),
            ]),
            SizedBox(
              height: 30.h,
            ),
            Container(
                decoration:
                BoxDecoration(border: Border.all(color: Colors.black)),
                width: 200.w,
                height: 170.h,
                child: Text('칼로리에 맞는 적당한 음식 사진 혹은 이미지')),
            SizedBox(
              height: 30.h,
            ),
            SizedBox(
                width: 250.w,
                child: Text('제로 콜라 1캔 만큼의 칼로리를 소비했습니다!',
                    style: TextStyle(fontSize: 17.sp))),
            SizedBox(height: 40.h),
            ElevatedButton(
                onPressed: (() {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SecondPage(mytime, mykcal)));
                  print('데이터 넘기기 완료');
                }),
                child: Text('메뉴로 돌아가기'),
                style: ElevatedButton.styleFrom(minimumSize: Size(280.w, 40.h)))
          ],
        ),
      ),
    );
  }

  void dispose() {
    super.dispose();
  }

}

// 데이터 받아오고  나머지는 꾸미는 거 남음.
/*class Information {
  int? mytime;
  int? mykcal;

  Information({this.mytime, this.mykcal});
}*/
