
Future<bool> isConnected() async {
  // var connectivityResult = await (Connectivity().checkConnectivity());
  // return connectivityResult != ConnectivityResult.none;
  return Future.value(true);
}
