import 'package:flutter/material.dart';
import 'package:wave_odc/config/app_provider.dart';
import 'package:wave_odc/config/hive_config.dart';
import 'package:wave_odc/config/notification_config.dart';
import 'package:wave_odc/pages/shared_pages/connexion/connectivity_wrapper.dart';
import 'package:wave_odc/providers/data_provider.dart';
import 'package:wave_odc/routes/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await hiveConfig();
  setupLocator();
  notificationConfig();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DataProvider(),
      child: MaterialApp( 
        title: 'Sama Calpé',
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: routes,
        builder: (context, child) {
          return ConnectivityWrapper(child: child!);
        },
      ),
    );
  }
}
