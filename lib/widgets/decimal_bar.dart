import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart' as provider;

import '../main.dart';

class DecimalBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'decimals:',
          style: GoogleFonts.judson(fontSize: 16),
        ),
        SizedBox(width: 20),
        GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
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
          '${(provider.Provider.of<Data>(context, listen: true).decimalPoint)}',
          style: GoogleFonts.judson(fontSize: 16),
        ),
        SizedBox(width: 20),
        GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              provider.Provider.of<Data>(context, listen: false)
                  .increaseDecimal();
            },
            child: Icon(Icons.arrow_right)),
      ],
    );
  }
}
