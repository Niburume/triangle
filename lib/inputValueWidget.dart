import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trekut/triangleBrain.dart';

import 'main.dart';

class InputValue extends StatelessWidget {
  final String name;
  final String units;
  final double width;
  TextEditingController textFieldController = TextEditingController();

  InputValue(
      {required this.name,
      required this.units,
      this.width = 70,
      required this.textFieldController});

  @override
  Widget build(BuildContext context) {
    String labelText = name + units;

    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(5),
            height: 30,
            width: width,
            child: TextField(
              keyboardType: TextInputType.none,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: textFieldController,
              maxLines: 1,
              style: TextStyle(fontSize: 11),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(5, 1, 5, 1.0),
                  labelText: labelText,
                  // hintText: 'Alpha',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.green),
                    borderRadius: BorderRadius.circular(5),
                  )),
            ),
          ),
          // Text(units!),
          // IconButton(
          //   icon: Center(
          //     child: Icon(
          //       Icons.clear,
          //       size: 10,
          //     ),
          //   ),
          //   onPressed: () {},
          // )
        ],
      ),
    );
  }
}
