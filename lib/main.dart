import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trekut/constants.dart';
import 'package:trekut/painters/ExampleTriangelDraw.dart';
import 'package:trekut/resultPage.dart';
import 'package:trekut/triangleBrain.dart';
import 'package:trekut/painters/triangleDraw.dart';
import 'package:trekut/inputValueWidget.dart';
import 'package:trekut/widgets/Separator.dart';
import 'package:trekut/widgets/decimalBar.dart';
import 'Buttons.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:animated_icon_button/animated_icon_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider<Data>(
      create: (context) => Data(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => MainView(),
          '/results': (context) => ResultPage(),
        },
        initialRoute: '/',
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
  @override
  void initState() {
    super.initState();
    alphaController.text = '90';
    controllers = [
      sideAController,
      sideBController,
      sideCController,
      alphaController,
      bettaController,
      gammaController,
    ];
    focusNodes = {
      sideANode: sideAController,
      sideBNode: sideBController,
      sideCNode: sideCController,
      alphaNode: alphaController,
      bettaNode: bettaController,
      gammaNode: gammaController
    };
  }

  TextEditingController sideAController = TextEditingController();
  TextEditingController sideBController = TextEditingController();
  TextEditingController sideCController = TextEditingController();
  TextEditingController alphaController = TextEditingController();
  TextEditingController bettaController = TextEditingController();
  TextEditingController gammaController = TextEditingController();
  TextEditingController numberPadController = TextEditingController();
  List<TextEditingController> controllers = [];

  final sideANode = FocusNode();
  final sideBNode = FocusNode();
  final sideCNode = FocusNode();

  final alphaNode = FocusNode();
  final bettaNode = FocusNode();
  final gammaNode = FocusNode();
  Map<FocusNode, TextEditingController> focusNodes = {};

  bool rtIsOff = false;

  void changeText(TextEditingController controller, String symbol) {
    if (symbol == deleteSymbol) {
      if (controller.text.length == 0) {
        return;
      }
      ;
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

  void addSymbol(String symbol) {
    focusNodes.forEach((key, value) {
      key.hasFocus ? changeText(value, symbol) : null;
    });
  }

  int countActiveControllers() {
    int activeControllers = 0;
    controllers.forEach((element) {
      if (element.text.isNotEmpty) {
        activeControllers++;
      }
    });
    return activeControllers;
  }

  void buttonTapped(String symbol) {
    addSymbol(symbol);
    if (symbol == deleteSymbol && countActiveControllers() == 2) {
      focusNodes.forEach((key, value) {
        Provider.of<Data>(context, listen: false).changeController(value, true);
      });
    }
    if (countActiveControllers() >= 3) {
      print(countActiveControllers());
      focusNodes.forEach((key, value) {
        Provider.of<Data>(context, listen: false)
            .changeController(value, value.text.isNotEmpty);
        print(value.text.isNotEmpty);
        print(countActiveControllers());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TriangleModel triangle = Provider.of<Data>(context, listen: true).triangle;
    return Scaffold(
      body: Container(
        color: backgroundDrawing,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                // constraints: BoxConstraints(minHeight: 250),
                child: ExampleTriangleDrawing(
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
                          isActive: Provider.of<Data>(context, listen: true)
                              .controllersListVisibility[sideCController],
                        ),
                        InputValue(
                          name: 'side b',
                          units: '',
                          textFieldController: sideBController,
                          focus: sideBNode,
                          isActive: Provider.of<Data>(context, listen: true)
                              .controllersListVisibility[sideBController],
                        ),
                        InputValue(
                          name: 'side a',
                          units: '',
                          textFieldController: sideAController,
                          focus: sideANode,
                          isActive: Provider.of<Data>(context, listen: true)
                              .controllersListVisibility[sideAController],
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
                          isActive: Provider.of<Data>(context, listen: true)
                              .controllersListVisibility[alphaController],
                          readOnly: !rtIsOff,
                        ),
                        InputValue(
                          name: bettaSymbol,
                          units: degreeSymbol,
                          textFieldController: bettaController,
                          focus: bettaNode,
                          isActive: Provider.of<Data>(context, listen: true)
                              .controllersListVisibility[bettaController],
                        ),
                        InputValue(
                          name: gammaSymbol,
                          units: degreeSymbol,
                          textFieldController: gammaController,
                          focus: gammaNode,
                          isActive: Provider.of<Data>(context, listen: true)
                              .controllersListVisibility[gammaController],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // SizedBox(
              //   height: 5,
              // ),

              Center(child: Text(triangle.message)),
              Separator(),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // DecimalBar(),
                      AnimatedToggleSwitch<bool>.dual(
                        current: rtIsOff,
                        first: false,
                        second: true,
                        dif: 10.0,
                        borderColor: Colors.transparent,
                        borderWidth: 1.0,
                        height: 24,
                        indicatorSize: const Size(30, 24),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1.5),
                          ),
                        ],
                        onChanged: (b) => setState(() {
                          rtIsOff = b;
                          Provider.of<Data>(context, listen: false).clearData();
                          if (rtIsOff) {
                            alphaController.text = '';
                            triangle.alpha = 0;
                          } else {
                            alphaController.text = '90';
                            triangle.alpha = 90;
                          }
                        }),
                        colorBuilder: (b) =>
                            b ? buttonBackgroundColor : buttonBackgroundColor,
                        iconBuilder: (value) => value
                            ? ImageIcon(
                                AssetImage("images/triangleRegular.png"),
                                size: 15,
                                color: Colors.white,
                              )
                            : ImageIcon(
                                AssetImage("images/triangleRight.png"),
                                size: 14,
                                color: Colors.white,
                              ),
                        textBuilder: (value) => value
                            ? Center(
                                child: Text(
                                // '◺',
                                '',
                                style: TextStyle(color: Colors.grey[900]),
                              ))
                            : Center(
                                // '△'
                                child: Text('90$degreeSymbol',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.black))),
                      ),
                      // SizedBox(
                      //   width: 5,
                      // ),
                      AnimatedIconButton(
                        size: 24,
                        onPressed: () {
                          Provider.of<Data>(context, listen: false).clearData();
                          sideAController.clear();
                          sideBController.clear();
                          sideCController.clear();
                          alphaController.clear();
                          bettaController.clear();
                          gammaController.clear();
                          setState(() {
                            if (!rtIsOff) {
                              alphaController.text = '90';
                            }
                            // rtIsOff = true;
                          });
                        },
                        duration: const Duration(milliseconds: 500),
                        splashColor: Colors.transparent,
                        icons: const <AnimatedIconItem>[
                          AnimatedIconItem(
                            icon: Icon(Icons.clear, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ],
                  )),

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
                                  triangle.sideA =
                                      double.parse(sideAController.text);
                                if (sideBController.text.isNotEmpty)
                                  triangle.sideB =
                                      double.parse(sideBController.text);
                                if (sideCController.text.isNotEmpty)
                                  triangle.sideC =
                                      double.parse(sideCController.text);
                                if (alphaController.text.isNotEmpty)
                                  triangle.alpha =
                                      double.parse(alphaController.text);
                                if (bettaController.text.isNotEmpty)
                                  triangle.betta =
                                      double.parse(bettaController.text);
                                if (gammaController.text.isNotEmpty)
                                  triangle.gamma =
                                      double.parse(gammaController.text);

                                triangle = triangle.findAllData(triangle);
                                if (triangle.isValid) {
                                  triangle.fillDrawData(triangle);
                                  Provider.of<Data>(context, listen: false)
                                      .triangle = triangle;
                                  this.setState(() {
                                    Navigator.pushNamed(context, '/results',
                                        arguments: {
                                          'triangle': triangle,
                                        });
                                  });
                                } else {
                                  this.setState(() {});
                                }
                                ;
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
          ),
        ),
      ),
    );
  }
}

class Data extends ChangeNotifier {
  Map<TextEditingController, bool> controllersListVisibility = {};

  // void hideControllers() {
  //   print(controllersListVisibility.values);
  //   notifyListeners();
  // }

  void changeController(TextEditingController controller, bool value) {
    controllersListVisibility[controller] = value;
    notifyListeners();
  }

  int decimalPoint = 2;
  TriangleModel triangle = TriangleModel(alpha: 90);

  void clearData() {
    triangle.resetTriangle();
    controllersListVisibility.clear();
  }

  void increaseDecimal() {
    if (decimalPoint <= 4) decimalPoint += 1;
    notifyListeners();
  }

  void decreaseDecimal() {
    if (decimalPoint >= 2) decimalPoint -= 1;
    notifyListeners();
  }
}
