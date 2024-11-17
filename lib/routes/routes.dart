import 'package:flutter/material.dart';
import 'package:wave_odc/config/app_provider.dart';
import 'package:wave_odc/pages/auth/code/code.dart';
import 'package:wave_odc/pages/auth/error/error.dart';
import 'package:wave_odc/pages/auth/login/login.dart';
import 'package:wave_odc/pages/auth/register/register.dart';
import 'package:wave_odc/pages/auth/verify_code/verify_code.dart';
import 'package:wave_odc/pages/client/home/home.dart' as client;
import 'package:wave_odc/pages/client/transaction/transaction.dart';
import 'package:wave_odc/pages/vendor/home/home.dart' as vendor;
import 'package:wave_odc/pages/client/transfer/transfer.dart';
import 'package:wave_odc/pages/vendor/transaction/transaction.dart';


import 'package:wave_odc/services/auth/user_auth_service.dart';

Future<Widget> getInitialScreen() async {
  UserAuthService userAuthService = locator<UserAuthService>();
  final token = await userAuthService.getUserInfo();
  if (token != null && token.isNotEmpty) {
    return const PinCodeScreen();
  } else {
    return const LoginPage();
  }
}

void login(BuildContext context)=> Navigator.pushReplacementNamed(context, "/login");

final routes = {
  "/login": (context) => FutureBuilder<Widget>(
        future: getInitialScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return snapshot.data ?? ErrorPage(onRetry: ()=>login(context));
          }
        },
      ),
  "/register": (context) => const RegisterPage(),
  "/error": (context) => ErrorPage(onRetry: ()=>login(context)),
  "/verify/code": (context) => const VerifyCodePage(),
  "/client/home": (context) => const client.Home(),
  "/vendor/home": (context) => const vendor.Home(),
  "/client/transfer": (context) => const Transfer(),
  "/vendor/transactions": (context)=>const TransactionVendor(),
  "/client/transactions": (context)=>const TransactionClient(),
};
