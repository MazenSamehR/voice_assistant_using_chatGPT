import 'package:flutter/material.dart';
import 'package:voice_assistant_app/pallete.dart';

class FeatureBox extends StatelessWidget {
  final Color color;
  final String headerText;
  final String subText;
  const FeatureBox({super.key, required this.color, required this.headerText, required this.subText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20, left: 15),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                headerText,
                style: const TextStyle(
                  fontFamily: 'Cera Pro',
                  color:Pallete.blackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(
                subText,
                style: const TextStyle(
                  fontFamily: 'Cera Pro',
                  color:Pallete.blackColor,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
