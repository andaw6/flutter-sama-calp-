import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:wave_odc/config/app_provider.dart';
import 'package:wave_odc/config/hive_config.dart';
import 'package:wave_odc/config/notification_config.dart';
import 'package:wave_odc/models/users/user_info.dart';
import 'package:wave_odc/pages/shared_pages/connexion/connectivity_wrapper.dart';
import 'package:wave_odc/providers/data_provider.dart';
import 'package:wave_odc/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:wave_odc/services/user/user_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await hiveConfig();
  setupLocator();
  notificationConfig();
  runApp(const MyApp());
  test();
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

Future<void> test() async{
  final userService = locator<UserService>();
  final logger = Logger();
  UserInfo? user = await userService.findById(id: "f924bdca-d18e-49d8-a407-a16fc2b544e9");
  logger.w(user);
}