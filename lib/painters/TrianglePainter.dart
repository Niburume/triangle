import 'package:flutter/cupertino.dart';

import '../constants.dart';
import '../triangleBrain.dart';
import 'dart:math' as math;

class TrianglePainter extends CustomPainter {
  TriangleModel triangle = TriangleModel();
  int decimalSet = 2;
  TrianglePainter({required this.triangle});

  @override
  final path = Path();

  final drawTriangle = Paint()
    ..color = lineDrawing
    ..style = PaintingStyle.stroke
    ..strokeWidth = lineWeight;

  void paint(Canvas canvas, Size size) {
    print(
        'h = ${triangle.hTopToBottom}topCorner = ${triangle.topCorner}, leftCorner = ${triangle.leftCorner}, rightCorner = ${triangle.rightCorner}, leftSide = ${triangle.leftSide}, rightSide = ${triangle.rightSide}, bottomSide = ${triangle.bottomSide}');

    scaleFactor = size.width / triangle.bottomSide!;
    print('scale: $scaleFactor');

    final double xA = 0;
    final double yA = size.height;
    final double yB = size.height - triangle.hTopToBottom * scaleFactor;
    final double xB = triangle.leftOfH * scaleFactor;

    final double xC = scaleFactor * triangle.bottomSide!;
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
    TextSpan leftSideSpan = TextSpan(
        style: spanTextStyle, text: triangle.leftSide!.toStringAsFixed(2));
    TextPainter leftSideText =
        TextPainter(text: leftSideSpan, textDirection: TextDirection.ltr);

    canvas.translate(0, size.height);
    canvas.rotate(-triangle.leftCorner!.radians);
    leftSideText.layout();
    leftSideText.paint(
        canvas, Offset((triangle.leftSide! * scaleFactor) / 2 - 20, -20));

    //Rotate canvas back to original
    canvas.rotate(triangle.leftCorner!.radians);

    //Draw rightSideText
    TextSpan rightSideSpan = TextSpan(
        style: spanTextStyle, text: triangle.rightSide!.toStringAsFixed(2));
    TextPainter rightSideText =
        TextPainter(text: rightSideSpan, textDirection: TextDirection.ltr);
    canvas.translate(size.width, 0);
    canvas.rotate(triangle.rightCorner!.radians);
    rightSideText.layout();
    rightSideText.paint(
        canvas, Offset(-((triangle.rightSide! * scaleFactor) / 2 - 20), -20));
    //Rotate canvas back to original
    canvas.rotate(-triangle.rightCorner!.radians);

    //Draw bottomSideText
    TextSpan bottomSideSpan = TextSpan(
        style: spanTextStyle, text: triangle.bottomSide!.toStringAsFixed(2));
    TextPainter bottomSideText =
        TextPainter(text: bottomSideSpan, textDirection: TextDirection.ltr);
    canvas.translate(-size.width, 0);
    bottomSideText.layout();

    bottomSideText.paint(
        canvas, Offset((triangle.bottomSide! * scaleFactor) / 2 - 10, 0));

    // Draw angles
    // DrawLeftAngle
    canvas.translate(0, 0);
    TextSpan leftCorner = TextSpan(
        style: spanTextStyle,
        text: '${triangle.leftCorner!.toStringAsFixed(2)}$degreeSymbol');
    TextPainter leftCornerText =
        TextPainter(text: leftCorner, textDirection: TextDirection.ltr);
    leftCornerText.layout();
    leftCornerText.paint(canvas, Offset(0, 0));

    //DrawRightAngle

    TextSpan rightCorner = TextSpan(
        style: spanTextStyle,
        text: '${triangle.rightCorner!.toStringAsFixed(2)}$degreeSymbol');
    TextPainter rightCornerText =
        TextPainter(text: rightCorner, textDirection: TextDirection.ltr);
    rightCornerText.layout();
    rightCornerText.paint(canvas, Offset(size.width - 20, 0));

    // DrawTopAngle
    TextSpan span = TextSpan(
        style: spanTextStyle,
        text: '${triangle.topCorner!.toStringAsFixed(2)}$degreeSymbol');
    TextPainter top = TextPainter(text: span, textDirection: TextDirection.ltr);

    top.layout();
    top.paint(
        canvas,
        Offset(triangle.leftOfH * scaleFactor - 20,
            -triangle.hTopToBottom * scaleFactor - 20));
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
