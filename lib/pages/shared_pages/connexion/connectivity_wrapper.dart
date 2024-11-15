import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:wave_odc/providers/data_provider.dart';

class ConnectivityWrapper extends StatefulWidget {
  final Widget child;

  const ConnectivityWrapper({
    super.key,
    required this.child,
  });

  @override
  State<ConnectivityWrapper> createState() => _ConnectivityWrapperState();
}

/* class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  late final InternetConnectionChecker _checker;
  StreamSubscription<InternetConnectionStatus>? _subscription;
  bool _isOffline = false;

  @override
  void initState() {
    super.initState();
    _checker = InternetConnectionChecker();
    _initConnectivityListener();
  }

  void _initConnectivityListener() {
    // _checker.onStatusChange.listen((status) {
    //   if (mounted) {
    //     final isOffline = status == InternetConnectionStatus.disconnected;
    //     setState(() => _isOffline = isOffline);
    //     Provider.of<DataProvider>(context, listen: false).setConnectivity(isOffline);
    //   }
    // });
     _subscription = _checker.onStatusChange.listen((status) {
      if (mounted) {
        final isOffline = status == InternetConnectionStatus.disconnected;
        setState(() => _isOffline = isOffline);
        Provider.of<DataProvider>(context, listen: false).setConnectivity(isOffline);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_isOffline)
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: Material(
              child: Container(
                color: Colors.red,
                padding: const EdgeInsets.all(8),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wifi_off,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Vous êtes hors ligne',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
 */

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  late final InternetConnectionChecker _checker;
  StreamSubscription<InternetConnectionStatus>? _subscription;
  final logger = Logger();
  bool _isOffline = false;
  bool _showAlert = true;

  @override
  void initState() {
    super.initState();
    _checker = InternetConnectionChecker();
    _initConnectivityListener();
  }

  void _initConnectivityListener() {
    _subscription = _checker.onStatusChange.listen((status) {
      if (mounted) {
        final isOffline = status == InternetConnectionStatus.disconnected;
        setState(() {
          _isOffline = isOffline;
          _showAlert =
              isOffline; // Réafficher l'alerte quand on perd la connexion
        });
        logger.d("Test connexion $isOffline");
        Provider.of<DataProvider>(context, listen: false)
            .setConnectivity(isOffline);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_isOffline && _showAlert)
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: Material(
              child: Container(
                color: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.wifi_off,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Vous êtes hors ligne',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => setState(() => _showAlert = false),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
