import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SidePainter extends CustomPainter {
  FlutterTts tts = FlutterTts();
  final List<Offset> points;
  final double ratio;

  SidePainter({required this.points, required this.ratio}) {
    tts.setLanguage('ko');
    tts.setSpeechRate(0.4);
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
        ..strokeWidth = 2;

      /*var leftPaint = Paint()
        ..color = Colors.lightBlue
        ..strokeWidth = 2;
      var rightPaint = Paint()
        ..color = Colors.yellow
        ..strokeWidth = 2;
      var bodyPaint = Paint()
        ..color = Colors.pink
        ..strokeWidth = 2;*/

      canvas.drawPoints(
        PointMode.points,
        points.sublist(0, 34).map((point) => point * ratio).toList(),
        pointPaint,
      );

      if (checkAngle(calculateAngle(points[11], points[23], points[25])!) &&
          checkAngle(calculateAngle(points[23], points[25], points[27])!)) {
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
      } // 허리가 참이고 무릎이 참일때
      else if (checkAngle(
              calculateAngle(points[11], points[23], points[25])!) &&
          !checkAngle(calculateAngle(points[23], points[25], points[27])!)) {
        tts.speak('무릎을 똑바로 펴세요');
        canvas.drawPoints(
          PointMode.polygon,
          [
            points[11],
            points[23],
          ].map((point) => point * ratio).toList(),
          defaultPaint,
        );
        canvas.drawPoints(
          PointMode.polygon,
          [
            points[23],
            points[25],
            points[27],
          ].map((point) => point * ratio).toList(),
          checkPaint,
        );
      } //허리가 참이고 무릎이 거짓일때
      else if (!checkAngle(
              calculateAngle(points[11], points[23], points[25])!) &&
          checkAngle(calculateAngle(points[23], points[25], points[27])!)) {
        tts.speak('허리를 똑바로 펴세요');
        canvas.drawPoints(
          PointMode.polygon,
          [
            points[11],
            points[23],
            points[25],
          ].map((point) => point * ratio).toList(),
          checkPaint,
        );
        canvas.drawPoints(
          PointMode.polygon,
          [
            points[25],
            points[27],
          ].map((point) => point * ratio).toList(),
          defaultPaint,
        ); //허리가 거짓이고 무릎이 참일때
      } else {
        tts.speak('허리와 무릎을 똑바로 펴세요');
        canvas.drawPoints(
          PointMode.polygon,
          [
            points[11],
            points[23],
            points[25],
            points[27],
          ].map((point) => point * ratio).toList(),
          checkPaint,
        ); //허리 무릎 모두 거짓일때
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

bool checkAngle(double input) {
  return input > 160 ? true : false;
}
