import 'package:flutter/material.dart';
import 'package:wave_odc/models/my_color.dart';

class AppColors {
  // Primary Colors
  static const Color primaryLight = Color(0xFF1E3C72);
  static const Color primaryDark = Color(0xFF2A5298);
  static const Color primaryAccent = Color(0xFF2E58B1);

  // Text Colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF1E3C72);
  static const Color textHint = Colors.grey;

  // Button Colors
  static const Color buttonBackground = Colors.white;
  static const Color buttonText = primaryColor;

  // Input Colors
  static const Color inputFill = Colors.grey;
  static const Color inputBorder = Color(0xFF1E3C72);
  static const Color inputError = Colors.red;

  static const Color primaryColor = Color(0xFF1E3D59);
  static const Color secondaryColor = Color(0xFF0077B6);
  static const Color accentColor = Color(0xFF99D5F1);
  static const Color backgroundColor = Color(0xFFF5F9FC);

  static const MyColor codePage = MyColor(
    primaryColor: Color(0xFF2A3F54),
    secondaryColor: Color(0xFF4D6E92),
    accentColor: Color(0xFF8EB4C9),
    backgroundColor: Color(0xFF1F2833),
  );
}


