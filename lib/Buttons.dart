import 'package:flutter/material.dart';
import 'package:trekut/constants.dart';

class NumberPadButton extends StatelessWidget {
  final String symbol;
  final TextEditingController controller;
  final Function onChange;

  NumberPadButton({
    required this.symbol,
    required this.controller,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.text = symbol;
          onChange();
        },
        child: Container(
          margin: EdgeInsets.all(1),
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: buttonBackgroundColor,
              borderRadius: BorderRadius.circular(1)),
          child: Center(
              child: Text(
            symbol,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          )),
        ),
      ),
    );
  }
}
