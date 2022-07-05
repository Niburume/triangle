import 'package:flutter/material.dart';
import 'package:trekut/constants.dart';
import 'package:trekut/painters/TrianglePainter.dart';
import 'package:trekut/painters/ExampleRightTrianglePainter.dart';
import 'package:trekut/triangleBrain.dart';
import 'ExampleTrianglePaint.dart';

class ExampleTriangleDrawing extends StatelessWidget {
  TriangleModel triangle = TriangleModel();

  ExampleTriangleDrawing({required this.triangle});

  @override
  Widget build(BuildContext context) {
    triangle = triangle.findAllData(triangle);
    triangle.fillDrawData(triangle);

    if (triangle.alpha == 90) {
      {
        TriangleModel exampleTriangle =
            TriangleModel(sideA: 50, sideB: 40, sideC: 30);
        exampleTriangle = exampleTriangle.findAllData(exampleTriangle);
        double widthOfScreen = MediaQuery.of(context).size.width;
        return Center(
          child: Container(
            color: backgroundDrawing,
            // color: Colors.lightBlueAccent,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(10),
            width: (widthOfScreen - 40) * scaleForDrawing,
            height: (widthOfScreen - 40) * scaleForDrawing,
            child: CustomPaint(
              foregroundPainter:
                  ExampleRightTrianglePainter(triangle: exampleTriangle),
            ),
          ),
        );
      }
    } else {
      TriangleModel exampleTriangle =
          TriangleModel(alpha: 60, betta: 60, gamma: 60);
      exampleTriangle = exampleTriangle.findAllData(exampleTriangle);
      double widthOfScreen = MediaQuery.of(context).size.width;
      // scaleFactor = widthOfScreen / exampleTriangle.bottomSide!;
      return Center(
        child: Container(
          color: backgroundDrawing,
          // color: Colors.lightBlueAccent,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(10),
          width: (widthOfScreen - 40) * scaleForDrawing,
          height: (widthOfScreen - 40) * scaleForDrawing,
          child: CustomPaint(
            foregroundPainter:
                TriangleExamplePainter(triangleExample: exampleTriangle),
          ),
        ),
      );
    }
  }
}
