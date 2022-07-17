import 'package:flutter/material.dart';
import 'package:trekut/constants.dart';
import 'package:trekut/triangleBrain.dart';
import 'Painters/ExampleTrianglePainter.dart';

class TriangleExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TriangleModel exampleTriangle =
        TriangleModel(alpha: 60, betta: 60, gamma: 60);
    exampleTriangle = exampleTriangle.findAllData(exampleTriangle);
    double widthOfScreen = MediaQuery.of(context).size.width;
    print(widthOfScreen);
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
