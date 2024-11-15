import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityUtil {
  static Future<bool> checkConnection() async {
    return await InternetConnectionChecker().hasConnection;
  }
}