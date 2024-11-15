import 'package:flutter/material.dart';
import 'package:wave_odc/pages/auth/register/widgets/register_buttons.dart';
import 'package:wave_odc/pages/auth/register/widgets/register_form.dart';
import 'package:wave_odc/pages/auth/register/widgets/register_header.dart';
import 'package:wave_odc/utils/constants/colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primaryColor, AppColors.secondaryColor],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                children: [
                  const RegisterHeader(),
                  const SizedBox(height: 40),
                  RegisterForm(
                    formKey: _formKey,
                    primaryColor: AppColors.primaryColor,
                    secondaryColor: AppColors.secondaryColor,
                    backgroundColor: AppColors.backgroundColor,
                  ),
                  const SizedBox(height: 32),
                  RegisterButtons(
                    accentColor: AppColors.accentColor,
                    secondaryColor: AppColors.secondaryColor,
                    onRegister: () {
                      if (_formKey.currentState!.validate()) {

                      }
                    },
                    onLogin: () {
                      Navigator.pushReplacementNamed(context, "/login");
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
