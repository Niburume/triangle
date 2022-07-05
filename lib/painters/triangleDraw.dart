import 'package:flutter/material.dart';
import 'package:trekut/constants.dart';
import 'package:trekut/painters/TrianglePainter.dart';
import 'package:trekut/painters/ExampleRightTrianglePainter.dart';
import 'package:trekut/triangleBrain.dart';
import 'ExampleTrianglePaint.dart';
import 'RightTrianglePainter.dart';

class TriangleDrawing extends StatelessWidget {
  TriangleModel triangle = TriangleModel();

  TriangleDrawing({required this.triangle});

  @override
  Widget build(BuildContext context) {
    if (triangle.alpha == 90 && triangle.isValid) {
      {
        double height = triangle.hTopToBottom;
        double width = triangle.bottomSide!;
        // print('htop = ${exampleTriangle.hTopToBottom}');
        double widthOfScreen = MediaQuery.of(context).size.width;
        scaleFactor = widthOfScreen / triangle.bottomSide!;
        return Center(
          child: Container(
            color: backgroundDrawing,
            // color: Colors.lightBlueAccent,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(10),
            width: width * scaleFactor * scaleForDrawing,
            height: height * scaleFactor * scaleForDrawing,
            child: CustomPaint(
              foregroundPainter: RightTrianglePainter(triangle: triangle),
            ),
          ),
        );
      }
    }

    if (triangle.isValid) {
      double height = triangle.hTopToBottom;
      double width = triangle.bottomSide!;
      double widthOfScreen = MediaQuery.of(context).size.width;
      scaleFactor = widthOfScreen / triangle.bottomSide!;
      // print(
      //     'triangleDraw: ${triangle.hTopToBottom} : alpha = ${triangle.alpha}, betta = ${triangle.betta}, sideA = ${triangle.sideA}, largestSide = ${triangle.largestSide}');

      return Center(
        child: Container(
          color: backgroundDrawing,
          // color: Colors.lightBlueAccent,
          padding: EdgeInsets.all(20),
          width: width * scaleFactor * scaleForDrawing,
          height: height * scaleFactor * scaleForDrawing,
          child: CustomPaint(
            foregroundPainter: TrianglePainter(triangle: triangle),
          ),
        ),
      );
    }
    return Container();
  }
}
