import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'cameraPage.dart';
import 'component/model_inference_service.dart';
import 'component/service_locator.dart';
import 'main.dart';

class ThirdPage extends StatefulWidget {
  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  TextEditingController? _targetNumber = TextEditingController(text: '0');
  TextEditingController? _targetSet = TextEditingController(text: '0');
  TextEditingController? _targetSeconds = TextEditingController(text: '0');
  bool _targetLimit = false;
  int? index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[
        Column(
          children: <Widget>[
            Center(
              child: Container(
                width: 300.w,
                height: 70.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('\n운동 선택하기',
                        style: TextStyle(
                            fontSize: 25.sp, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Stack(children: <Widget>[
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return AlertDialog(
                          content: SizedBox(
                              width: 200.w,
                              height: 200.h,
                              child: Column(children: <Widget>[
                                SizedBox(
                                    height: 30.h,
                                    width: 200.w,
                                    child: Text('목표치 설정')),
                                SizedBox(height: 30.h),
                                Row(children: <Widget>[
                                  SizedBox(width: 10.w),
                                  SizedBox(
                                      width: 50.w,
                                      height: 50.h,
                                      child: TextField(
                                        controller: _targetNumber,
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder()),
                                      )),
                                  SizedBox(width: 50.w, child: Text(' 회 씩')),
                                  SizedBox(
                                      width: 50.w,
                                      height: 50.h,
                                      child: TextField(
                                        controller: _targetSet,
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder()),
                                      )),
                                  SizedBox(width: 50.w, child: Text(' 세트'))
                                ]),
                                SizedBox(height: 10.h),
                                SizedBox(
                                    height: 30.h,
                                    width: 200.w,
                                    child: Row(children: <Widget>[
                                      Checkbox(
                                        value: _targetLimit,
                                        onChanged: (value) {
                                          setState(() {
                                            _targetLimit = value!;
                                            print('$_targetLimit');
                                          });
                                        },
                                      ),
                                      Text('제한 없음'),
                                    ])),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      100.0.w, 0.0, 0.0, 0.0),
                                  child: SizedBox(
                                    height: 40.h,
                                    child: ElevatedButton(
                                        onPressed: (() {
                                          index = 0;
                                          _onTapCamera(context);
                                        }),
                                        child: Icon(Icons.arrow_forward)),
                                  ),
                                ),
                              ])),
                        );
                      });
                    },
                  );
                },
                child: Container(
                  width: 330.w,
                  height: 200.h,
                  child: ClipRRect(
                    child: Image.asset('assets/lunge_960_555.jpg',
                        fit: BoxFit.fitWidth),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Positioned(
                  top: 140.0.h,
                  left: 20.0.w,
                  child: GestureDetector(
                      onTap: () {
                        //Navigator.of(context).pushReplacementNamed('/fifth');
                      },
                      child: Text('런지',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)))),
              Positioned(
                top: 0.0.h,
                left: 280.0.w,
                child: IconButton(
                    icon: Icon(Icons.info_outline_rounded,
                        color: Colors.white, size: 30),
                    onPressed: (() {
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext ctx) {
                            return AlertDialog(
                                content: SizedBox(
                                    width: 200.w,
                                    height: 280.h,
                                    child: Column(children: <Widget>[
                                      ClipRRect(
                                        child: Image.asset(
                                            'assets/lunge_960_555.jpg'),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      SizedBox(height: 10.h),
                                      SizedBox(
                                          height: 30.h,
                                          width: 200.w,
                                          child: Text('런지 가이드')),
                                      SizedBox(
                                          height: 100.h,
                                          width: 200.w,
                                          child: Text(
                                              '1. 뒤쪽 무릎이 내려갈 때 앞 무릎을 90도 각도로 확실하게 구부려 무릎이 발가락 바깥으로 나가지 않도록 합니다.\n'
                                              '2. 상체는 꼿꼿이 펴서 앞 뒤로 구부러지지 않도록 합니다.\n '
                                              '3. 뒤쪽 무릎을 서서히 낮추어서 무릎이 바닥에 세게 닿지 않도록 합니다.',
                                              style: TextStyle(fontSize: 10)))
                                    ])),
                                actions: [
                                  FlatButton(
                                      child: Text('확인'),
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      }),
                                ]);
                          });
                      //Navigator.of(context).pushReplacementNamed('/lunge');
                    })),
              )
            ]),
            SizedBox(height: 15.h),
            Stack(children: <Widget>[
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return AlertDialog(
                          content: SizedBox(
                              width: 200.w,
                              height: 200.h,
                              child: Column(children: <Widget>[
                                SizedBox(
                                    height: 30.h,
                                    width: 200.w,
                                    child: Text('목표치 설정')),
                                SizedBox(height: 30.h),
                                Row(children: <Widget>[
                                  SizedBox(width: 10.w),
                                  SizedBox(
                                      width: 50.w,
                                      height: 50.h,
                                      child: TextField(
                                        controller: _targetSeconds,
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder()),
                                      )),
                                  SizedBox(width: 50.w, child: Text(' 초 씩')),
                                  SizedBox(
                                      width: 50.w,
                                      height: 50.h,
                                      child: TextField(
                                        controller: _targetSet,
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder()),
                                      )),
                                  SizedBox(width: 50.w, child: Text(' 세트'))
                                ]),
                                SizedBox(height: 10.h),
                                SizedBox(
                                    height: 30.h,
                                    width: 200.w,
                                    child: Row(children: <Widget>[
                                      Checkbox(
                                        value: _targetLimit,
                                        onChanged: (value) {
                                          setState(() {
                                            _targetLimit = value!;
                                            print('$_targetLimit');
                                          });
                                        },
                                      ),
                                      Text('제한 없음'),
                                    ])),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      100.0.w, 0.0, 0.0, 0.0),
                                  child: SizedBox(
                                    height: 40.h,
                                    child: ElevatedButton(
                                        onPressed: (() {
                                          index = 1;
                                          _onTapCamera(context);
                                        }),
                                        child: Icon(Icons.arrow_forward)),
                                  ),
                                ),
                              ])),
                        );
                      });
                    },
                  );
                },
                child: Container(
                  width: 330.w,
                  height: 200.h,
                  child: ClipRRect(
                    child: Image.asset('assets/sideplank_512_296.jpg',
                        fit: BoxFit.fitWidth),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Positioned(
                  top: 140.0.h,
                  left: 20.0.w,
                  child: GestureDetector(
                      onTap: () {
                        //Navigator.of(context).pushReplacementNamed('/fifth');
                      },
                      child: Text('사이드플랭크',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          )))),
              Positioned(
                top: 0.0.h,
                left: 280.0.w,
                child: IconButton(
                    icon: Icon(Icons.info_outline_rounded,
                        color: Colors.white, size: 30),
                    onPressed: (() {
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext ctx) {
                            return AlertDialog(
                                content: SizedBox(
                                    width: 200.w,
                                    height: 280.h,
                                    child: Column(children: <Widget>[
                                      ClipRRect(
                                        child: Image.asset(
                                            'assets/sideplank_512_296.jpg'),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      SizedBox(height: 10.h),
                                      SizedBox(
                                          height: 30.h,
                                          width: 200.w,
                                          child: Text('사이드플랭크 가이드')),
                                      SizedBox(
                                          height: 100.h,
                                          width: 200.w,
                                          child: Text(
                                              '1. 옆으로 누운 자세에서 팔꿈치를 자신의 어깨 밑에 위치합니다.\n'
                                              '2. 팔꿈치, 엉덩이, 발뒤꿈치가 일직선이 되게 만들어줍니다.\n '
                                              '3. 팔꿈치를 수직상태로 바닥에 붙이고 엉덩이를 들어 올려줍니다.',
                                              style: TextStyle(fontSize: 10)))
                                    ])),
                                actions: [
                                  FlatButton(
                                      child: Text('확인'),
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      }),
                                ]);
                          });
                    })),
              )
            ]),
            SizedBox(height: 15.h),
            Stack(children: <Widget>[
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return AlertDialog(
                          content: SizedBox(
                              width: 200.w,
                              height: 200.h,
                              child: Column(children: <Widget>[
                                SizedBox(
                                    height: 30.h,
                                    width: 200.w,
                                    child: Text('목표치 설정')),
                                SizedBox(height: 30.h),
                                Row(children: <Widget>[
                                  SizedBox(width: 10.w),
                                  SizedBox(
                                      width: 50.w,
                                      height: 50.h,
                                      child: TextField(
                                        controller: _targetNumber,
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder()),
                                      )),
                                  SizedBox(width: 50.w, child: Text(' 회 씩')),
                                  SizedBox(
                                      width: 50.w,
                                      height: 50.h,
                                      child: TextField(
                                        controller: _targetSet,
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder()),
                                      )),
                                  SizedBox(width: 50.w, child: Text(' 세트'))
                                ]),
                                SizedBox(height: 10.h),
                                SizedBox(
                                    height: 30.h,
                                    width: 200.w,
                                    child: Row(children: <Widget>[
                                      Checkbox(
                                        value: _targetLimit,
                                        onChanged: (value) {
                                          setState(() {
                                            _targetLimit = value!;
                                            print('$_targetLimit');
                                          });
                                        },
                                      ),
                                      Text('제한 없음'),
                                    ])),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      100.0.w, 0.0, 0.0, 0.0),
                                  child: SizedBox(
                                    height: 40.h,
                                    child: ElevatedButton(
                                        onPressed: (() {
                                          index = 2;
                                          _onTapCamera(context);
                                        }),
                                        child: Icon(Icons.arrow_forward)),
                                  ),
                                ),
                              ])),
                        );
                      });
                    },
                  );
                },
                child: Container(
                  width: 330.w,
                  height: 200.h,
                  child: ClipRRect(
                    child: Image.asset('assets/squat_640_370.jpg',
                        fit: BoxFit.fitWidth),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Positioned(
                  top: 140.0.h,
                  left: 20.0.w,
                  child: GestureDetector(
                      onTap: () {
                        //Navigator.of(context).pushReplacementNamed('/fifth');
                      },
                      child: Text('스쿼트',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          )))),
              Positioned(
                top: 0.0.h,
                left: 280.0.w,
                child: IconButton(
                    icon: Icon(Icons.info_outline_rounded,
                        color: Colors.white, size: 30),
                    onPressed: (() {
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext ctx) {
                            return AlertDialog(
                                content: SizedBox(
                                    width: 200.w,
                                    height: 280.h,
                                    child: Column(children: <Widget>[
                                      ClipRRect(
                                        child: Image.asset(
                                            'assets/squat_640_370.jpg'),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      SizedBox(height: 10.h),
                                      SizedBox(
                                          height: 30.h,
                                          width: 200.w,
                                          child: Text('스쿼트 가이드')),
                                      SizedBox(
                                          height: 100.h,
                                          width: 200.w,
                                          child: Text(
                                              '1. 양발을 어깨너비로 벌리고 편하게 섭니다.\n'
                                              '2. 허리를 꼿꼿이 세운 채, 무릎을 굽혀 상체를 내립니다.\n '
                                              '* 내려갈 때 숨을 들이쉬고, 올라올 때 숨을 내쉽니다.'
                                              ' 발뒤꿈치가 바닥에서 떨어지지 않도록 합니다. *',
                                              style: TextStyle(fontSize: 10)))
                                    ])),
                                actions: [
                                  FlatButton(
                                      child: Text('확인'),
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      }),
                                ]);
                          });
                    })),
              )
            ]),
            SizedBox(height: 30.h),
          ],
        ),
      ]),
    );
  }
  void _onTapCamera(BuildContext context) {
    locator<ModelInferenceService>().setModelConfig();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CameraPage(index: index!);
        },
      ),
    );
  }
}
