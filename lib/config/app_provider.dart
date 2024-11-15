import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wave_odc/pages/auth/controllers/auth_controller.dart';
import 'package:wave_odc/providers/cache_provider.dart';
import 'package:wave_odc/services/auth_service.dart';
import 'package:wave_odc/services/bill_service.dart';
import 'package:wave_odc/services/company_service.dart';
import 'package:wave_odc/services/config_service.dart';
import 'package:wave_odc/services/contact_service.dart';
import 'package:wave_odc/services/notification_service.dart';
import 'package:wave_odc/services/provider/http.dart';
import 'package:wave_odc/services/provider/interfaces/IApiService.dart';
import 'package:wave_odc/services/token_expiry_service.dart';
import 'package:wave_odc/services/token_service.dart';
import 'package:wave_odc/services/transaction_service.dart';
import 'package:wave_odc/services/user_auth_service.dart';
import 'package:wave_odc/services/user_service.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator
      .registerLazySingleton(() => TokenExpiryService(locator<TokenService>()));

  locator.registerFactoryParam<IApiService, String, void>(
      (baseUrl, _) => HttpApiService(baseUrl));

  locator.registerFactoryParam<AuthController, BuildContext, void>(
      (context, _) => AuthController(context));

  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => UserAuthService());
  locator.registerLazySingleton(() => ConfigService());
  locator.registerLazySingleton(() => TokenService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => CacheProvider());
  locator.registerLazySingleton(() => TransactionService());
  locator.registerLazySingleton(() => NotificationService());
  locator.registerLazySingleton(() => ContactService());
  locator.registerLazySingleton(() => CompanyService());
  locator.registerLazySingleton(() => BillService());
}
