import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trekut/triangleBrain.dart';
import 'dart:math' as math;

import '../constants.dart';

class TriangleExamplePainter extends CustomPainter {
  TriangleModel triangleExample = TriangleModel();

  TriangleExamplePainter({required this.triangleExample});

  @override
  final path = Path();

  final drawTriangle = Paint()
    ..color = Colors.grey
    ..style = PaintingStyle.stroke
    ..strokeWidth = lineWeight;

  void paint(Canvas canvas, Size size) {
    triangleExample = triangleExample.findAllData(triangleExample);
    print(
        'h = ${triangleExample.hTopToBottom}topCorner = ${triangleExample.topCorner}, leftCorner = ${triangleExample.leftCorner}, rightCorner = ${triangleExample.rightCorner}, leftSide = ${triangleExample.leftSide}, rightSide = ${triangleExample.rightSide}, bottomSide = ${triangleExample.bottomSide}');

    scaleFactor = size.width / triangleExample.bottomSide!;

    final double xA = 0;
    final double yA = size.height;
    final double yB = size.height - triangleExample.hTopToBottom * scaleFactor;
    final double xB = triangleExample.leftOfH * scaleFactor;

    final double xC = scaleFactor * triangleExample.bottomSide!;
    ;
    final double yC = size.height;

    //Draw the triangle...
    // BottomSide
    path.moveTo(xA, yA); //done
    path.lineTo(xC, yC); //done
    // print('scale: $scaleFactor sideB: ${triangle.sideB}');

    //RightSide
    path.lineTo(xB, yB);
    // LeftSide
    path.close();
    // canvas.translate(size.height / 2, size.height / 2);
    // canvas.rotate(3.14159 / 4.0);

    canvas.drawPath(path, drawTriangle);

    //Draw texts

    //Draw leftSideText
    TextSpan leftSideSpan = TextSpan(style: spanTextStyle, text: 'side c');
    TextPainter leftSideText =
        TextPainter(text: leftSideSpan, textDirection: TextDirection.ltr);

    canvas.translate(0, size.height);
    canvas.rotate(-triangleExample.leftCorner!.radians);
    leftSideText.layout();
    leftSideText.paint(canvas,
        Offset((triangleExample.leftSide! * scaleFactor) / 2 - 20, -20));

    //Rotate canvas back to original
    canvas.rotate(triangleExample.leftCorner!.radians);

    //Draw rightSideText
    TextSpan rightSideSpan = TextSpan(style: spanTextStyle, text: 'side a');
    TextPainter rightSideText =
        TextPainter(text: rightSideSpan, textDirection: TextDirection.ltr);
    canvas.translate(size.width, 0);
    canvas.rotate(triangleExample.rightCorner!.radians);
    rightSideText.layout();
    rightSideText.paint(canvas,
        Offset(-((triangleExample.rightSide! * scaleFactor) / 2 + 20), -20));
    //Rotate canvas back to original
    canvas.rotate(-triangleExample.rightCorner!.radians);

    //Draw bottomSideText
    TextSpan bottomSideSpan = TextSpan(style: spanTextStyle, text: 'side b');
    TextPainter bottomSideText =
        TextPainter(text: bottomSideSpan, textDirection: TextDirection.ltr);
    canvas.translate(-size.width, 0);
    bottomSideText.layout();

    bottomSideText.paint(canvas,
        Offset((triangleExample.bottomSide! * scaleFactor) / 2 - 10, 0));

    // Draw angles
    // DrawLeftAngle
    canvas.translate(0, 0);
    TextSpan leftCorner =
        TextSpan(style: spanTextStyle, text: '$alphaSymbol $degreeSymbol');
    TextPainter leftCornerText =
        TextPainter(text: leftCorner, textDirection: TextDirection.ltr);
    leftCornerText.layout();
    leftCornerText.paint(canvas, Offset(0, 0));

    //DrawRightAngle

    TextSpan rightCorner =
        TextSpan(style: spanTextStyle, text: '$gammaSymbol $degreeSymbol');
    TextPainter rightCornerText =
        TextPainter(text: rightCorner, textDirection: TextDirection.ltr);
    rightCornerText.layout();
    rightCornerText.paint(canvas, Offset(size.width - 20, 0));

    // DrawTopAngle
    TextSpan span =
        TextSpan(style: spanTextStyle, text: '$bettaSymbol $degreeSymbol');
    TextPainter top = TextPainter(text: span, textDirection: TextDirection.ltr);

    top.layout();
    top.paint(
        canvas,
        Offset(triangleExample.leftOfH * scaleFactor - 20,
            -triangleExample.hTopToBottom * scaleFactor - 20));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
    // throw UnimplementedError();
  }
}

extension on num {
  /// This is an extension we created so we can easily convert a value  /// to a radian value
  double get radians => (this * math.pi) / 180.0;
}
