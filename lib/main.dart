import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trekut/constants.dart';
import 'package:trekut/painters/RightTriangleExample.dart';
import 'package:trekut/painters/TriangleExample.dart';
import 'package:trekut/resultPage.dart';
import 'package:trekut/triangleBrain.dart';
import 'package:trekut/inputValueWidget.dart';
import 'package:trekut/widgets/Separator.dart';
import 'Buttons.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

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
        title: 'TriangleData',
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
  bool rtIsOff = false;
  double angle = 0;
  @override
  void initState() {
    super.initState();
    if (rtIsOff) {
      alphaController.text = '';
    } else {
      alphaController.text = '90';
      Provider.of<Data>(context, listen: false).triangle.alpha = 90;
    }

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

  void _flip() {
    angle = (angle + pi) % (2 * pi);
  }

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
    HapticFeedback.lightImpact();
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
    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;
    double _textFieldHeight = heightOfScreen / 25;
    double _textFieldWidth = widthOfScreen / 5;
    return Scaffold(
      body: Container(
        color: backgroundDrawing,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: angle),
                  duration: Duration(milliseconds: 300),
                  builder: (BuildContext context, double val, __) {
                    return (Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(val),
                      child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          // constraints: BoxConstraints(minHeight: 250),
                          child: rtIsOff
                              ? Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.identity()..rotateY(pi),
                                  child: TriangleExample())
                              : RightTriangleExample()),
                    ));
                  }),
              // INPUT WIDGETS
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                          height: _textFieldHeight,
                          width: _textFieldWidth,
                        ),
                        InputValue(
                          name: bettaSymbol,
                          units: degreeSymbol,
                          textFieldController: bettaController,
                          focus: bettaNode,
                          isActive: Provider.of<Data>(context, listen: true)
                              .controllersListVisibility[bettaController],
                          height: _textFieldHeight,
                          width: _textFieldWidth,
                        ),
                        InputValue(
                          name: 'side a',
                          units: '',
                          textFieldController: sideAController,
                          focus: sideANode,
                          isActive: Provider.of<Data>(context, listen: true)
                              .controllersListVisibility[sideAController],
                          height: _textFieldHeight,
                          width: _textFieldWidth,
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: 15,
                    // ),
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
                          height: _textFieldHeight,
                          width: _textFieldWidth,
                        ),
                        InputValue(
                          name: 'side b',
                          units: '',
                          textFieldController: sideBController,
                          focus: sideBNode,
                          isActive: Provider.of<Data>(context, listen: true)
                              .controllersListVisibility[sideBController],
                          height: _textFieldHeight,
                          width: _textFieldWidth,
                        ),
                        InputValue(
                          name: gammaSymbol,
                          units: degreeSymbol,
                          textFieldController: gammaController,
                          focus: gammaNode,
                          isActive: Provider.of<Data>(context, listen: true)
                              .controllersListVisibility[gammaController],
                          height: _textFieldHeight,
                          width: _textFieldWidth,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: FittedBox(
                        child: Text(
                          triangle.message,
                          style: GoogleFonts.judson(
                              fontSize: 16, color: Colors.black87),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 5,
              // ),
              Separator(),
              //ANIMATED CLEAR BAR
              Container(
                  height: heightOfScreen / 20,
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
                          HapticFeedback.lightImpact();
                          rtIsOff = b;
                          Provider.of<Data>(context, listen: false).clearData();
                          if (rtIsOff) {
                            alphaController.text = '';
                            triangle.alpha = 0;
                            _flip();
                          } else {
                            if (countActiveControllers() == 3) {
                              focusNodes.forEach((key, value) {
                                key.hasFocus ? value.clear() : null;
                              });
                            }
                            ;
                            alphaController.text = '90';
                            buttonTapped('');
                            triangle.alpha = 90;
                            _flip();
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
                      AnimatedIconButton(
                        size: 24,
                        onPressed: () {
                          HapticFeedback.lightImpact();
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
                  constraints: BoxConstraints(
                      maxHeight: widthOfScreen, minHeight: widthOfScreen - 40),
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
                                  triangle.message = 'Put any 3 values';
                                  HapticFeedback.lightImpact();
                                  print('validation: ${triangle.isValid}');
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
                                  String message = triangle.message;
                                  triangle.resetTriangle();
                                  triangle.message = message;
                                  setState(() {});
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
