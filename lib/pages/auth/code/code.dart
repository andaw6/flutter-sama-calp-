import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:wave_odc/config/app_provider.dart';
import 'package:wave_odc/pages/auth/code/widgets/numeric_keypad_widget.dart';
import 'package:wave_odc/pages/auth/code/widgets/pin_dots_widget.dart';
import 'package:wave_odc/pages/auth/code/widgets/pin_logo_widget.dart';
import 'package:wave_odc/pages/auth/code/widgets/pin_title_widget.dart';
import 'package:wave_odc/pages/auth/controllers/auth_controller.dart';
import 'package:wave_odc/services/auth/user_auth_service.dart';
import 'package:wave_odc/utils/constants/colors.dart';
import 'dart:math' as math;

import 'package:wave_odc/services/auth/auth_service.dart';

class PinCodeScreen extends StatefulWidget {
  const PinCodeScreen({super.key});

  @override
  PinCodeScreenState createState() => PinCodeScreenState();
}

class PinCodeScreenState extends State<PinCodeScreen>
    with SingleTickerProviderStateMixin {
  String currentPin = '';
  late AnimationController _shakeController;
  late Animation<double> _fadeAnimation;
  final authService = locator<AuthService>();
  final _userAuthService = locator<UserAuthService>();
  final logger = Logger();
  late AuthController _authController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _addDigit(String digit) {
    if (currentPin.length < 4) {
      setState(() {
        currentPin += digit;
      });
      if (currentPin.length == 4) {
        _checkPin();
      }
    }
  }

  Future<void> _checkPin() async {
    String? phoneNumber = await _userAuthService.getPhoneNumberUser();
    logger.i("Le numéro de téléphone $phoneNumber et le passe word: $currentPin");
    if(phoneNumber == null){
      Navigator.pushReplacementNamed(context, "/error");
      return;
    }
    if (await _authController.login(
        phone: phoneNumber, password: currentPin)) {
      _resetPin();
    } else {
      _shakeController.forward(from: 0.0);
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) _resetPin();
      });
    }
  }

  void _resetPin() {
    setState(() {
      currentPin = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    _authController = locator<AuthController>(param1: context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primaryColor, AppColors.secondaryColor],
            // colors: [Color(0xFF1E88E5), Color(0xFF7E57C2)],
            stops: [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: AnimatedBuilder(
            animation: _shakeController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                    _shakeController.value *
                        10 *
                        math.sin(_shakeController.value * math.pi * 8),
                    0),
                child: child,
              );
            },
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const PinLogo(),
                      const SizedBox(height: 40),
                      PinTitle(),
                      const SizedBox(height: 40),
                      PinDots(currentPin: currentPin),
                      const SizedBox(height: 60),
                      NumericKeypad(onDigitPressed: _addDigit),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
