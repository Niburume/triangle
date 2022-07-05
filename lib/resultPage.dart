import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trekut/constants.dart';
import 'package:trekut/triangleBrain.dart';
import 'package:trekut/painters/triangleDraw.dart';
import 'package:trekut/widgets/Separator.dart';
import 'package:trekut/widgets/decimalBar.dart';

import 'infoAboutTriangel.dart';
import 'main.dart';

int turn = 1;

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    TriangleModel triangle = arguments['triangle'];
    print(triangle.alpha);
    var decimalPoint = Provider.of<Data>(context, listen: true).decimalPoint;
    return Scaffold(
      body: Container(
        color: backgroundDrawing,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // SizedBox(
                  //   height: 80,
                  // ),
                  Container(
                      constraints: BoxConstraints(minHeight: 250),
                      child: TriangleDrawing(triangle: triangle)),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InfoW(
                        value: triangle.alpha.toStringAsFixed(decimalPoint),
                        title: alphaSymbol,
                      ),
                      InfoW(
                          title: bettaSymbol,
                          value: triangle.betta.toStringAsFixed(decimalPoint)),
                      InfoW(
                          title: gammaSymbol,
                          value: triangle.gamma.toStringAsFixed(decimalPoint)),
                      InfoW(
                          title: 'side a',
                          value: triangle.sideA.toStringAsFixed(decimalPoint)),
                      InfoW(
                          title: 'side b',
                          value: triangle.sideB.toStringAsFixed(decimalPoint)),
                      InfoW(
                          title: 'side c',
                          value: triangle.sideC.toStringAsFixed(decimalPoint)),
                      // InfoW(title: 'area', value: triangle.betta.toString()),
                      Separator(),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            DecimalBar(),
                          ],
                        ),
                      ),
                    ],
                  ),

                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: buttonBackgroundColor),
                      onPressed: () {
                        Provider.of<Data>(context, listen: false)
                            .triangle
                            .resetTriangle();
                        Navigator.pop(context);

                        // Navigator.pushNamed(context, '/', arguments: {
                        //   'triangle': triangle,
                        // });
                      },
                      child: Container(
                        // color: buttonBackgroundColor,
                        height: 50,
                        // width: double.infinity,
                        child: Center(child: Text('ReCalculate')),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
