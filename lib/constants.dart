import 'package:flutter/material.dart';

// print(
// '$action : alpha = $alpha, betta = $betta, gamma = $gamma, sideA = $sideA, sideB = $sideB, sideC = $sideC, largestSide = $largestSide');

const deleteSymbol = 'ᐊ';
const alphaSymbol = 'α';
const bettaSymbol = 'β';
const gammaSymbol = 'γ';
const sideATXT = 'sideA';
const sideBTXT = 'sideB';
const sideCTXT = 'sideC';
final String degreeSymbol = '°';
const PI = 3.141592653589793238;
const scaleForDrawing = 1;
double scaleFactor = 2;

//UISIZES
const widthOfTextField = 40.0;

// UIColors
const Color buttonTextColor = Colors.white;
const Color buttonBackgroundColor = Colors.lightBlueAccent;
const Color titleTextColor = Colors.lightBlue;
const Color valueTextColor = Colors.lightBlue;
const Color _spanTextColor = Colors.green;

//drawingColors
const Color backgroundDrawing = Colors.transparent;
const Color lineDrawing = Colors.black;

const lineWeight = 1.0;

const TextStyle infoTitleStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: titleTextColor);

const TextStyle valueTitleStyle =
    TextStyle(fontWeight: FontWeight.w300, fontSize: 15, color: titleTextColor);

const TextStyle spanTextStyle =
    TextStyle(fontWeight: FontWeight.w300, fontSize: 14, color: _spanTextColor);
