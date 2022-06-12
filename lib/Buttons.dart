import 'package:flutter/material.dart';
import 'package:trekut/constants.dart';

class NumberPadButton extends StatelessWidget {
  final String? symbol;
  NumberPadButton({required this.symbol});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(1),
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: buttonBackgroundColor,
            borderRadius: BorderRadius.circular(1)),
        child: Center(
            child: Text(
          symbol!,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        )),
      ),
    );
  }
}
