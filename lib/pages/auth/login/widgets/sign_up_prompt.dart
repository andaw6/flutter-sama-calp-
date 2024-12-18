import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class SignUpPrompt extends StatelessWidget {
  const SignUpPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, "/register");
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.white.withOpacity(0.9)),
          children: const[
             TextSpan(text: "Vous n'avez pas de compte ? "),
            TextSpan(
              text: 'Inscrivez-vous',
              style:  TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}