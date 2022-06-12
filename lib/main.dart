import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trekut/constants.dart';
import 'package:trekut/triangleBrain.dart';
import 'package:trekut/triangleDraw.dart';
import 'package:trekut/inputValueWidget.dart';
import 'Buttons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  TriangleModel triangle = TriangleModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
      create: (context) => Data(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Set any 3 values'),
            leading: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                print('a');
              },
            ),
          ),
          body: SafeArea(
            child: MainView(triangle: triangle),
          ),
        ),
      ),
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({
    Key? key,
    required this.triangle,
  }) : super(key: key);

  final TriangleModel triangle;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    double widthOfScreen = MediaQuery.of(context).size.width;
    TextEditingController sideAController = TextEditingController();
    TextEditingController sideBController = TextEditingController();
    TextEditingController sideCController = TextEditingController();
    TextEditingController alphaController = TextEditingController();
    TextEditingController bettaController = TextEditingController();
    TextEditingController gammaController = TextEditingController();

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.arrow_left,
                      size: 24,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      Provider.of<Data>(context, listen: true)
                          .decimalSet
                          .toString(),
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print('Button');
                    },
                    child: Icon(
                      Icons.arrow_right,
                      size: 24,
                    ),
                  )
                ],
              ),

              // CLEAR BUTTON

              ElevatedButton(
                onPressed: () {
                  widget.triangle.resetTriangle();
                  Provider.of<Data>(context, listen: false).data.clear();
                  sideAController.clear();
                  sideBController.clear();
                  sideCController.clear();
                  alphaController.clear();
                  bettaController.clear();
                  gammaController.clear();
                  setState(() {});
                },
                child: Icon(Icons.close, size: 14),
              )
            ],
          ),
        ),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.all(5),
          child: TriangleDrawing(
            triangle: widget.triangle,
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InputValue(
                  name: 'side c',
                  units: '',
                  textFieldController: sideCController,
                ),
                InputValue(
                  name: bettaSymbol,
                  units: degreeSymbol,
                  textFieldController: bettaController,
                ),
                InputValue(
                  name: 'side a',
                  units: '',
                  textFieldController: sideAController,
                ),
              ],
            ),
            // SizedBox(
            //   height: 15,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InputValue(
                  name: alphaSymbol,
                  units: degreeSymbol,
                  textFieldController: alphaController,
                ),
                InputValue(
                  name: 'side b',
                  units: '',
                  textFieldController: sideBController,
                ),
                InputValue(
                  name: gammaSymbol,
                  units: degreeSymbol,
                  textFieldController: gammaController,
                ),
              ],
            ),
          ],
        ),
        // TriangelPictureW(),
        SizedBox(
          height: 20,
        ),
        // Column(
        //   children: [
        //     InfoW(title: 'Side A', value: '250'),
        //     InfoW(title: 'Side B', value: '360'),
        //     InfoW(title: 'Side C', value: '900'),
        //     InfoW(title: alphaSymbol, value: '98'),
        //     InfoW(title: bettaSymbol, value: '60'),
        //     InfoW(title: gammaSymbol, value: '12'),
        //   ],
        // ),
        SizedBox(
          height: 5,
        ),
        Center(child: Text(widget.triangle.message)),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      NumberPadButton(
                        symbol: '1',
                      ),
                      NumberPadButton(
                        symbol: '2',
                      ),
                      NumberPadButton(
                        symbol: '3',
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      NumberPadButton(
                        symbol: '4',
                      ),
                      NumberPadButton(
                        symbol: '5',
                      ),
                      NumberPadButton(
                        symbol: '6',
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      NumberPadButton(
                        symbol: '7',
                      ),
                      NumberPadButton(
                        symbol: '8',
                      ),
                      NumberPadButton(
                        symbol: '9',
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      NumberPadButton(
                        symbol: '.',
                      ),
                      NumberPadButton(
                        symbol: '0',
                      ),
                      NumberPadButton(
                        symbol: 'ᐊ',
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      NumberPadButton(
                        symbol: 'Calculate',
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class Data extends ChangeNotifier {
  Map<String, double> data = {};
  double decimalSet = 2;
  void changeData(String name, String value) {
    data[name] = double.parse(value);
    notifyListeners();
  }
}
// class Data extends ChangeNotifier {
//
//   void changeString(String newString) {
//     data = newString;
//     notifyListeners();
//   }
// }
