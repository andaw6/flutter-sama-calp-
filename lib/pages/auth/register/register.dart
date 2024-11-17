import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:wave_odc/config/app_provider.dart';
import 'package:wave_odc/pages/auth/register/widgets/register_buttons.dart';
import 'package:wave_odc/pages/auth/register/widgets/register_form.dart';
import 'package:wave_odc/pages/auth/register/widgets/register_header.dart';
import 'package:wave_odc/services/auth/auth_service.dart';
import 'package:wave_odc/utils/constants/colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _authService = locator<AuthService>();
  final logger = Logger();

  final Map<String, TextEditingController> controllers = {
    'name': TextEditingController(),
    'phone': TextEditingController(),
    'email': TextEditingController(),
    'code': TextEditingController(),
    'address': TextEditingController(),
    'cni': TextEditingController(),
  };

  void register(List<String> champs) async{
    Map<String, String> data = {
      "name":    champs[0], "phone": champs[1],
      "email":   champs[2],  "code": champs[3],
      "adresse": champs[4],   "cni": champs[5]
    };
    bool result = await _authService.register(data: data);
    logger.i(result);
  }

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
                    controllers: controllers,
                  ),
                  const SizedBox(height: 32),
                  RegisterButtons(
                    accentColor: AppColors.accentColor,
                    secondaryColor: AppColors.secondaryColor,
                    onRegister: () {
                      if (_formKey.currentState!.validate()) {
                       final List<String> champs = [];
                       for(var ent in controllers.entries.toList()){
                         champs.add(ent.value.text);
                       }
                       register(champs);
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
