import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController codeController;
  final bool obscureCode;
  final VoidCallback toggleObscure;

  const LoginForm({
    required this.phoneController,
    required this.codeController,
    required this.obscureCode,
    required this.toggleObscure,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildTextField(
              controller: phoneController,
              label: 'Numéro de téléphone',
              icon: Icons.phone_android,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ce champ est obligatoire';
                } else if (!RegExp(r'^7[05-8]\d{7}$').hasMatch(value)) {
                  return 'Veuillez entrer un numéro de téléphone sénégalais valide';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: codeController,
              label: 'Code secret',
              icon: Icons.lock_rounded,
              isPassword: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ce champ est obligatoire';
                } else if (!RegExp(r'^\d{1,4}$').hasMatch(value)) {
                  return 'Le code doit être composé de 1 à 4 chiffres';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword && obscureCode,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(fontSize: 16, color: const Color(0xFF1E3C72)),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(icon, color: const Color(0xFF1E3C72), size: 22),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(obscureCode ? Icons.visibility : Icons.visibility_off, color: const Color(0xFF1E3C72), size: 22),
          onPressed: toggleObscure,
        )
            : null,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFF1E3C72), width: 2)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.red, width: 2)),
        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.red, width: 2)),
      ),
      validator: validator,
    );
  }
}
