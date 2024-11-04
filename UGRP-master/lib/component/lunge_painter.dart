import 'dart:math';
import 'dart:ui';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class LungePainter extends CustomPainter {
  final List<Offset> points;
  final double ratio;

  final FlutterTts tts = FlutterTts();

  LungePainter({required this.points, required this.ratio}){
    tts.setLanguage('kr');
    tts.setSpeechRate(1.0);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isNotEmpty) {
      var pointPaint = Paint()
        ..color = Colors.green
        ..strokeWidth = 8;
      var defaultPaint = Paint()
        ..color = Colors.green
        ..strokeWidth = 2;
      var checkPaint = Paint()
        ..color = Colors.red
        ..strokeWidth = 4;

      canvas.drawPoints(
        PointMode.points,
        points.sublist(0, 34).map((point) => point * ratio).toList(),
        pointPaint,
      );



      void check_balance(){
        if (!checkThighAngle(calculateAngle(points[28], points[26], points[24])!)
            || !checkThighAngle(calculateAngle(points[27], points[25], points[23])!)){
          canvas.drawPoints(
            PointMode.polygon,
            [
              points[28],
              points[26],
              points[24],
            ].map((point) => point * ratio).toList(),
            checkPaint,
          );
          tts.speak('허벅지를 조금 더 굽혀서 근육에 자극이 오도록 하세요!');
        }
        if (!checkThighAngle(calculateAngle(points[28], points[26], points[24])!)
            || !checkThighAngle(calculateAngle(points[27], points[25], points[23])!)){
          canvas.drawPoints(
            PointMode.polygon,
            [
              points[27],
              points[25],
              points[23],
            ].map((point) => point * ratio).toList(),
            checkPaint,
          );
          tts.speak('허벅지를 조금 더 굽혀서 근육에 자극이 오도록 하세요!');
        }
      }

      void check_balance2(){
        if (!checkThighAngle(calculateAngle(calavg(points[11],points[12]), calavg(points[24],points[23]), calavg(points[25], points[26]))!)){
          canvas.drawPoints(
            PointMode.polygon,
            [
              points[24],
              points[23],
              points[12],
              points[11],
            ].map((point) => point * ratio).toList(),
            checkPaint,
          );
          tts.speak('상체가 너무 숙여져 있습니다. 바닥과 수직이 되도록 하세요!');
        }
      }
      canvas.drawPoints(
        PointMode.polygon,
        [
          points[28],
          points[26],
          points[24],
          points[12],
          points[14],
          points[16],
          points[20],
        ].map((point) => point * ratio).toList(),
        defaultPaint,
      );

      canvas.drawPoints(
        PointMode.polygon,
        [
          points[12],
          points[11],
          points[13],
          points[15],
          points[19],
        ].map((point) => point * ratio).toList(),
        defaultPaint,
      );

      canvas.drawPoints(
        PointMode.polygon,
        [
          points[24],
          points[23],
        ].map((point) => point * ratio).toList(),
        defaultPaint,
      );
      canvas.drawPoints(
        PointMode.polygon,
        [
          points[11],
          points[23],
          points[25],
          points[27],
        ].map((point) => point * ratio).toList(),
        defaultPaint,
      );

      check_balance();
      check_balance2();
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

double? calculateAngle(Offset a, Offset b, Offset c) {
  var radians =
      atan2(c.dy - b.dy, c.dx - b.dx) - atan2(a.dy - b.dy, a.dx - b.dx);
  var angle = (radians * 180.0 / pi).abs();

  if (angle > 180.0) {
    angle = 360 - angle;
  }
  return angle;
}


bool checkThighAngle(double input) {
  return input < 100 ? true : false;
}

Offset calavg(Offset a, Offset b) {
  final c = (a+b)/2;
  return c;
}