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

TriangleModel triangle = TriangleModel();

class MyApp extends StatelessWidget {
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
            child: MainView(),
          ),
        ),
      ),
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({
    Key? key,
  }) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  TextEditingController sideAController = TextEditingController();
  TextEditingController sideBController = TextEditingController();
  TextEditingController sideCController = TextEditingController();
  TextEditingController alphaController = TextEditingController();
  TextEditingController bettaController = TextEditingController();
  TextEditingController gammaController = TextEditingController();
  TextEditingController numberPadController = TextEditingController();

  // final FocusNode focus = FocusNode();
  final sideANode = FocusNode();
  final sideBNode = FocusNode();
  final sideCNode = FocusNode();

  final alphaNode = FocusNode();
  final bettaNode = FocusNode();
  final gammaNode = FocusNode();

  void changeText(TextEditingController controller, String symbol) {
    if (symbol == deleteSymbol) {
      if (controller.text.length == 0) return;
      controller.text =
          controller.text.substring(0, controller.text.length - 1);
    } else if (controller.text.contains('.') && symbol == '.') {
      return;
    } else {
      controller.text += symbol;
    }
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
  }

  void buttonTapped(String symbol) {
    if (sideANode.hasFocus) changeText(sideAController, symbol);
    if (sideBNode.hasFocus) changeText(sideBController, symbol);
    if (sideCNode.hasFocus) changeText(sideCController, symbol);
    if (alphaNode.hasFocus) changeText(alphaController, symbol);
    if (bettaNode.hasFocus) changeText(bettaController, symbol);
    if (gammaNode.hasFocus) changeText(gammaController, symbol);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Visibility(
            visible: false,
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
                    triangle.resetTriangle();
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
        ),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.all(5),
          child: TriangleDrawing(
            triangle: triangle,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InputValue(
                    name: 'side c',
                    units: '',
                    textFieldController: sideCController,
                    focus: sideCNode,
                  ),
                  InputValue(
                    name: 'side b',
                    units: '',
                    textFieldController: sideBController,
                    focus: sideBNode,
                  ),
                  InputValue(
                    name: 'side a',
                    units: '',
                    textFieldController: sideAController,
                    focus: sideANode,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InputValue(
                    name: alphaSymbol,
                    units: degreeSymbol,
                    textFieldController: alphaController,
                    focus: alphaNode,
                  ),
                  InputValue(
                    name: bettaSymbol,
                    units: degreeSymbol,
                    textFieldController: bettaController,
                    focus: bettaNode,
                  ),
                  InputValue(
                    name: gammaSymbol,
                    units: degreeSymbol,
                    textFieldController: gammaController,
                    focus: gammaNode,
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(
          height: 5,
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
        Center(child: Text(triangle.message)),
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
                        controller: numberPadController,
                        onChange: () {
                          buttonTapped('1');
                        },
                      ),
                      NumberPadButton(
                        symbol: '2',
                        controller: numberPadController,
                        onChange: () {
                          buttonTapped('2');
                        },
                      ),
                      NumberPadButton(
                        symbol: '3',
                        controller: numberPadController,
                        onChange: () {
                          buttonTapped('3');
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      NumberPadButton(
                        symbol: '4',
                        controller: numberPadController,
                        onChange: () {
                          buttonTapped('4');
                        },
                      ),
                      NumberPadButton(
                        symbol: '5',
                        controller: numberPadController,
                        onChange: () {
                          buttonTapped('5');
                        },
                      ),
                      NumberPadButton(
                        symbol: '6',
                        controller: numberPadController,
                        onChange: () {
                          buttonTapped('6');
                        },
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      NumberPadButton(
                        symbol: '7',
                        controller: numberPadController,
                        onChange: () {
                          buttonTapped('7');
                        },
                      ),
                      NumberPadButton(
                        symbol: '8',
                        controller: numberPadController,
                        onChange: () {
                          buttonTapped('8');
                        },
                      ),
                      NumberPadButton(
                        symbol: '9',
                        controller: numberPadController,
                        onChange: () {
                          buttonTapped('9');
                        },
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      NumberPadButton(
                        symbol: '.',
                        controller: numberPadController,
                        onChange: () {
                          buttonTapped('.');
                        },
                      ),
                      NumberPadButton(
                        symbol: '0',
                        controller: numberPadController,
                        onChange: () {
                          buttonTapped('0');
                        },
                      ),
                      NumberPadButton(
                        symbol: deleteSymbol,
                        controller: numberPadController,
                        onChange: () {
                          buttonTapped(deleteSymbol);
                        },
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      NumberPadButton(
                        symbol: 'Calculate',
                        controller: numberPadController,
                        onChange: () {
                          if (sideAController.text.isNotEmpty)
                            triangle.sideA = double.parse(sideAController.text);
                          if (sideBController.text.isNotEmpty)
                            triangle.sideB = double.parse(sideBController.text);
                          if (sideCController.text.isNotEmpty)
                            triangle.sideC = double.parse(sideCController.text);
                          if (alphaController.text.isNotEmpty)
                            triangle.alpha = double.parse(alphaController.text);
                          if (bettaController.text.isNotEmpty)
                            triangle.betta = double.parse(bettaController.text);
                          if (gammaController.text.isNotEmpty)
                            triangle.gamma = double.parse(gammaController.text);
                          this.setState(() {});
                        },
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
