import 'package:flutter/material.dart';
import 'package:trekut/constants.dart';

class InfoW extends StatelessWidget {
  final String? title;
  final String? value;

  InfoW({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 5,
          child: Center(
            child: Text(
              title!,
              style: infoTitleStyle,
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 1,
            color: Colors.grey[500],
          ),
        ),
        Expanded(
          flex: 5,
          child: Center(
            child: Text(
              value!,
              style: valueTitleStyle,
            ),
          ),
        ),
        Expanded(flex: 1, child: Container()),
      ],
    );
  }
}
