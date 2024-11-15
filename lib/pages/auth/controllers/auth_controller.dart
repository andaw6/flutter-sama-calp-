import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wave_odc/config/app_provider.dart';
import 'package:wave_odc/enums/user/user_role.dart';
import 'package:wave_odc/providers/data_provider.dart';
import 'package:wave_odc/services/auth_service.dart';
import 'package:wave_odc/services/user_auth_service.dart';
import 'package:wave_odc/shared/widgets/error_dialog_widget.dart';

class AuthController {
  final _authService = locator<AuthService>();
  final _userAuthService = locator<UserAuthService>();
  final BuildContext _context;

  AuthController(this._context);

  Future<bool> login({required String phone, required String password, bool showError=false}) async {
    final isValid = await _authService.login(phone: phone, password: password);

    if (isValid) {
      await Provider.of<DataProvider>(_context, listen: false).fetchData();
      String? role = await _userAuthService.getUserRole();
      navigate(role);
      return true;
    }
    if(showError) {
      _showErrorDialog();
    }
    return false;
  }

  void navigate(String? userRole) {
    if (userRole == UserRole.client.name) {
      Navigator.pushReplacementNamed(_context, '/client/home');
    } else if (userRole == UserRole.vendor.name) {
      Navigator.pushReplacementNamed(_context, '/vendor/home');
    } else {
      Navigator.pushReplacementNamed(_context, '/error');
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: _context,
      builder: (context) => const ErrorDialog(message: "Le crédentiel est incorrect"),
    );
  }
}
