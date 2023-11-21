import 'package:attendencetracker/resources/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundButton extends StatelessWidget {
  const RoundButton(
      {super.key, required this.buttonName, required this.onPressed});

  final String buttonName;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(
          color: ColorsClass.amber,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: Text(buttonName,
                style: GoogleFonts.oxygen(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorsClass.white))),
      ),
    );
  }
}
