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
