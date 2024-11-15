import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:wave_odc/pages/auth/controllers/auth_controller.dart';

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final AuthController authController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final logger = Logger();

  LoginButton({
    required this.formKey,
    required this.authController,
    required this.phoneController,
    required this.passwordController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          String phone = phoneController.text;
          String password = passwordController.text;

          logger.i("Phone: $phone, Password: $password");

          await authController.login(phone: phone, password: password, showError: true);
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color(0xFF1E3C72),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        shadowColor: Colors.black38,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Se connecter',
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 0.5),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_rounded, size: 20),
        ],
      ),
    );
  }
}
