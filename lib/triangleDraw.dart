import 'package:flutter/material.dart';
import 'package:trekut/constants.dart';
import 'package:trekut/painters/TrianglePainter.dart';
import 'package:trekut/triangleBrain.dart';

import 'painters/ExampleTrianglePaint.dart';

class TriangleDrawing extends StatelessWidget {
  TriangleModel triangle = TriangleModel();

  TriangleDrawing({required this.triangle});

  @override
  Widget build(BuildContext context) {
    triangle = triangle.findAllData(triangle);

    if (triangle.isValid) {
      double height = triangle.hTopToBottom;
      double width = triangle.bottomSide!;
      print('htop = ${triangle.hTopToBottom}');
      double widthOfScreen = MediaQuery.of(context).size.width;
      scaleFactor = widthOfScreen / triangle.bottomSide!;
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
    } else {
      TriangleModel exampleTriangle =
          TriangleModel(alpha: 40, betta: 90, gamma: 50);
      exampleTriangle = exampleTriangle.findAllData(exampleTriangle);
      double height = exampleTriangle.hTopToBottom;
      double width = exampleTriangle.bottomSide!;
      print('htop = ${exampleTriangle.hTopToBottom}');
      double widthOfScreen = MediaQuery.of(context).size.width;
      scaleFactor = widthOfScreen / exampleTriangle.bottomSide!;
      return Center(
        child: Container(
          color: backgroundDrawing,
          // color: Colors.lightBlueAccent,
          padding: EdgeInsets.all(20),
          width: width * scaleFactor * scaleForDrawing,
          height: height * scaleFactor * scaleForDrawing,
          child: CustomPaint(
            foregroundPainter:
                TriangleExamplePainter(triangleExample: exampleTriangle),
          ),
        ),
      );
    }
  }
}
