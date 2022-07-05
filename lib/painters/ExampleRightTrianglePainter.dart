import 'package:flutter/material.dart';
import '../constants.dart';

import '../triangleBrain.dart';
import 'dart:math' as math;

class ExampleRightTrianglePainter extends CustomPainter {
  TriangleModel triangle = TriangleModel();
  int decimalPoint = 2;
  ExampleRightTrianglePainter({required this.triangle});

  @override
  final path = Path();

  final drawTriangle = Paint()
    ..color = Colors.grey
    ..style = PaintingStyle.stroke
    ..strokeWidth = lineWeight;

  void paint(Canvas canvas, Size size) {
    scaleFactor = size.width / (triangle.bottomSide!);
    // print(size.width);
    // print('height is ${triangle.leftSide!}');
    // print('scale is $scaleFactor');
    // print('leftSide ${triangle.leftSide}');
    // print('rightSide is ${triangle.rightSide}');
    // print('bottomSide ${triangle.bottomSide}');
    final double xA = 0;
    final double yA = triangle.leftSide! * scaleFactor;
    final double yB = 0;
    final double xB = 0;

    final double xC = scaleFactor * triangle.bottomSide!;
    ;
    final double yC = triangle.leftSide! * scaleFactor;

    //Draw the triangle...
    // BottomSide
    path.moveTo(0, 0);
    canvas.translate(0, size.width - triangle.leftSide! * scaleFactor);
    path.lineTo(xA, yA); //done
    path.lineTo(xC, yC); //done
    path.close();
    // draw rightCorner
    path.moveTo(0, triangle.leftSide! * scaleFactor - 20);
    path.lineTo(20, triangle.leftSide! * scaleFactor - 20);
    path.lineTo(20, triangle.leftSide! * scaleFactor);

    canvas.drawPath(path, drawTriangle);

    //Draw texts

    //Draw leftSideText
    TextSpan leftSideSpan = TextSpan(style: spanTextStyle, text: 'side c');
    TextPainter leftSideText =
        TextPainter(text: leftSideSpan, textDirection: TextDirection.ltr);

    canvas.translate(0, triangle.leftSide! * scaleFactor);
    canvas.rotate(-triangle.leftCorner!.radians);
    leftSideText.layout();
    leftSideText.paint(
        canvas, Offset((triangle.leftSide! * scaleFactor) / 2 - 20, -20));

    //Rotate canvas back to original
    canvas.rotate(triangle.leftCorner!.radians);

    //Draw rightSideText
    TextSpan rightSideSpan = TextSpan(style: spanTextStyle, text: 'side a');
    TextPainter rightSideText =
        TextPainter(text: rightSideSpan, textDirection: TextDirection.ltr);
    canvas.translate(triangle.bottomSide! * scaleFactor, 0);
    canvas.rotate(triangle.rightCorner!.radians);
    rightSideText.layout();
    rightSideText.paint(
        canvas, Offset(-((triangle.rightSide! * scaleFactor) / 2 + 10), -20));
    //Rotate canvas back to original
    canvas.rotate(-triangle.rightCorner!.radians);

    //Draw bottomSideText
    TextSpan bottomSideSpan = TextSpan(style: spanTextStyle, text: 'side b');
    TextPainter bottomSideText =
        TextPainter(text: bottomSideSpan, textDirection: TextDirection.ltr);
    canvas.translate(-triangle.bottomSide! * scaleFactor, 0);
    bottomSideText.layout();

    bottomSideText.paint(
        canvas, Offset((triangle.bottomSide! * scaleFactor) / 2 - 10, 0));

    // Draw angles
    // DrawLeftAngle
    canvas.translate(0, 0);
    TextSpan leftCorner =
        TextSpan(style: spanTextStyle, text: alphaSymbol + degreeSymbol);
    TextPainter leftCornerText =
        TextPainter(text: leftCorner, textDirection: TextDirection.ltr);
    leftCornerText.layout();
    leftCornerText.paint(canvas, Offset(0, 0));

    //DrawRightAngle

    TextSpan rightCorner =
        TextSpan(style: spanTextStyle, text: gammaSymbol + degreeSymbol);
    TextPainter rightCornerText =
        TextPainter(text: rightCorner, textDirection: TextDirection.ltr);
    rightCornerText.layout();
    rightCornerText.paint(
        canvas, Offset(triangle.bottomSide! * scaleFactor - 5, 0));

    // DrawTopAngle
    TextSpan span =
        TextSpan(style: spanTextStyle, text: bettaSymbol + degreeSymbol);
    TextPainter top = TextPainter(text: span, textDirection: TextDirection.ltr);

    top.layout();
    top.paint(canvas, Offset(0, -triangle.leftSide! * scaleFactor - 20));
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
