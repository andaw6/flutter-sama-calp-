import 'package:flutter/material.dart';
import 'package:wave_odc/utils/other/connectivity_util.dart';

extension ConnectivityContext on BuildContext {
  Future<bool> checkConnectivity() async {
    final hasConnection = await ConnectivityUtil.checkConnection();
    if (!hasConnection) {
      if (mounted) {
        ScaffoldMessenger.of(this).showSnackBar(
          const SnackBar(
            content: Text('Cette action nécessite une connexion Internet'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    return hasConnection;
  }
}