import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

import 'logger.dart';
import 'services/authService.dart';

final GetIt locator = GetIt.instance;

class LocatorInjector {
  static Future<void> setUpLocator() async {
    Logger log = getLogger('Locator Injector');
    log.d('Registering Navigation Service');
    locator.registerLazySingleton(() => NavigationService());
    log.d('Registering Dialog Service');
    locator.registerLazySingleton(() => DialogService());
    log.d('Registering Snackbar Service');
    locator.registerLazySingleton(() => SnackbarService());
    log.d('Registering Auth Service');
    locator.registerLazySingleton(() => AuthService());
    log.d('Registering FirebaseAuthentication Service');
    locator.registerLazySingleton(() => FirebaseAuthenticationService());
  }
}
