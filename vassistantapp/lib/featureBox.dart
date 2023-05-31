import 'package:flutter/material.dart';

import 'Colors/pallete.dart';

class FeatureBox extends StatelessWidget {
  final Color colorr;
  final String headerText;
  final String desText;
  const FeatureBox(
      {super.key,
      required this.colorr,
      required this.headerText,
      required this.desText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
        color: colorr,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          children: [
            Text(
              headerText,
              style: const TextStyle(
                fontFamily: 'Cera Pro',
                color: Pallete.blackColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              desText,
              style: const TextStyle(
                fontFamily: 'Cera Pro',
                color: Pallete.blackColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
