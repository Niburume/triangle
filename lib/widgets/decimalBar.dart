import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;

import '../main.dart';

class DecimalBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('decimals:'),
        SizedBox(width: 20),
        GestureDetector(
          onTap: () {
            provider.Provider.of<Data>(context, listen: false)
                .decreaseDecimal();
          },
          child: Icon(
            Icons.arrow_left,
            size: 24,
          ),
        ),
        SizedBox(width: 20),
        Text(
            '${(provider.Provider.of<Data>(context, listen: true).decimalPoint)}'),
        SizedBox(width: 20),
        GestureDetector(
            onTap: () {
              provider.Provider.of<Data>(context, listen: false)
                  .increaseDecimal();
            },
            child: Icon(Icons.arrow_right)),
      ],
    );
  }
}

// Container(
// child: Row(
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// TextButton(
// // style: ButtonStyle(
// //     backgroundColor:
// //         MaterialStateProperty.all(buttonBackgroundColor)),
// onPressed: () {
// triangle.resetTriangle();
// Provider.of<Data>(context, listen: false)
//     .triangle
//     .resetTriangle();
// sideAController.clear();
// sideBController.clear();
// sideCController.clear();
// alphaController.clear();
// bettaController.clear();
// gammaController.clear();
// setState(() {});
// },
// child: Icon(Icons.close, size: 20),
// )
// ],
// ),
// ),
