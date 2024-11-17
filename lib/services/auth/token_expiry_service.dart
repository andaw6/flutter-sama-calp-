import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wave_odc/services/auth/token_service.dart';

class TokenExpiryService {
  final TokenService _tokenService;
  BuildContext? _context;
  late Timer _tokenCheckTimer;

  TokenExpiryService(this._tokenService);

  void setContext(BuildContext context) {
    _context = context;
  }

  void startTokenExpiryCheck() {
    Future.delayed(const Duration(minutes: 1), () {
      _tokenCheckTimer = Timer.periodic(const Duration(minutes: 5), (timer) async {
        final isExpired = await _tokenService.isTokenExpired();

        if (isExpired && _context != null && _context!.mounted) {
          _tokenService.clearToken();
          Navigator.pushReplacementNamed(_context!, '/login');
        }
      });
    });
  }

  void stopTokenExpiryCheck() {
    if (_tokenCheckTimer.isActive) {
      _tokenCheckTimer.cancel();
    }
  }
}
