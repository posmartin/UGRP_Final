import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class SquatPainter extends CustomPainter {
  final List<Offset> points;
  final double ratio;

  SquatPainter({
    required this.points,
    required this.ratio,
  });

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

      void checkThigh(){ // 허벅지가 지면과 수평인지 확인
        if (!checkThighAngle(calculateAngle(points[28], points[26], points[24])!)
            && !checkThighAngle(calculateAngle(points[12], points[24], points[26])!)){
          canvas.drawPoints(
            PointMode.polygon,
            [
              points[28],
              points[26],
              points[24],
              points[12],
            ].map((point) => point * ratio).toList(),
            checkPaint,
          );
        }
      }

      void checkKneeToes(){ // 무릎이 발가락보다 앞으로 안나가게
        if (!checkKneeToesAngle(calculateAngle(points[26], points[28], points[32])!)){
          canvas.drawPoints(
            PointMode.polygon,
            [
              points[26],
              points[28],
              points[32],
            ].map((point) => point * ratio).toList(),
            checkPaint,
          );
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

      checkThigh();
      checkKneeToes();
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
  return input < 70 ? true : false;
}

bool checkKneeToesAngle(double input) {
  return input > 100 ? true : false;
}