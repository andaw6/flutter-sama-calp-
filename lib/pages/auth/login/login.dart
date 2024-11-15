import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:wave_odc/config/app_provider.dart';
import 'package:wave_odc/pages/auth/controllers/auth_controller.dart';
import 'package:wave_odc/pages/auth/login/widgets/login_button.dart';
import 'package:wave_odc/pages/auth/login/widgets/login_form.dart';
import 'package:wave_odc/pages/auth/login/widgets/login_header.dart';
import 'package:wave_odc/pages/auth/login/widgets/sign_up_prompt.dart';
import 'package:wave_odc/utils/constants/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  bool _obscureCode = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late AuthController  _authController;


  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed){
      if(!isAllowed){
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
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
            colors: [
              AppColors.primaryColor,
              AppColors.secondaryColor,
              AppColors.accentColor,
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const LoginHeader(),
                      const SizedBox(height: 48),
                      LoginForm(
                        phoneController: _phoneController,
                        codeController: _codeController,
                        obscureCode: _obscureCode,
                        toggleObscure: () => setState(() => _obscureCode = !_obscureCode),
                      ),
                      const SizedBox(height: 32),
                      LoginButton(
                        formKey: _formKey,
                        authController: _authController,
                        phoneController: _phoneController,
                        passwordController: _codeController
                      ),

                      const SizedBox(height: 24),
                      const SignUpPrompt(),
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

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}


