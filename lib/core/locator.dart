import 'package:dotdo/core/services/challengeService.dart';
import 'package:dotdo/core/services/pvpService.dart';
import 'package:dotdo/core/services/routineService.dart';
import 'package:dotdo/core/services/searchService.dart';
import 'package:dotdo/core/services/taskService.dart';
import 'package:dotdo/core/services/userService.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

import 'logger.dart';
import 'services/authService.dart';
import 'services/firestoreService.dart';

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
    locator.registerLazySingleton(() => FirestoreService());
    log.d('Registering Firestore Service');
    locator.registerLazySingleton(() => FirebaseAuthenticationService());
    log.d('Registering Task Service');
    locator.registerLazySingleton(() => TaskService());
    log.d('Registering Challenge Service');
    locator.registerLazySingleton(() => ChallengeService());
    log.d('Registering Routine Service');
    locator.registerLazySingleton(() => RoutineService());
    log.d('Registering User Service');
    locator.registerLazySingleton(() => UserService());
    log.d('Registering Search Service');
    locator.registerLazySingleton(() => SearchService());
    log.d('Registering Pvp Service');
    locator.registerLazySingleton(() => PvpService());
  }
}
