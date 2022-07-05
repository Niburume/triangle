import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';

class InputValue extends StatelessWidget {
  final String name;
  final String units;
  final double width;
  bool? isActive = true;
  bool? readOnly;
  FocusNode focus = FocusNode();
  TextEditingController textFieldController = TextEditingController();

  InputValue(
      {required this.name,
      required this.units,
      this.width = 70,
      required this.textFieldController,
      required this.focus,
      this.readOnly,
      this.isActive});

  @override
  Widget build(BuildContext context) {
    String labelText = name + units;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            height: 30,
            width: width,
            child: TextField(
              readOnly: readOnly ??= false,
              enabled: isActive,
              focusNode: focus,
              keyboardType: TextInputType.none,
              controller: textFieldController,
              maxLines: 1,
              style: TextStyle(fontSize: 11),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(5, 1, 5, 1.0),
                  labelText: labelText,
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
        ],
      ),
    );
  }
}
