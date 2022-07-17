import 'package:flutter/material.dart';
import 'package:trekut/constants.dart';
import 'package:trekut/painters/Painters/ExampleRightTrianglePainter.dart';
import 'package:trekut/triangleBrain.dart';

class RightTriangleExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}
