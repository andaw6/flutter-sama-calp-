import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.1),
          ),
          child: const Icon(Icons.account_balance_wallet, size: 60, color: Colors.white),
        ),
        const SizedBox(height: 32),
        Text(
          'Bienvenue',
          style: GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.2),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Connectez-vous pour effectuer\nvos transactions en toute sécurité',
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.white.withOpacity(0.85), height: 1.4),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
