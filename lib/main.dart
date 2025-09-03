import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/services.dart' show SystemChrome, DeviceOrientation;
import 'package:flutter/widgets.dart' show WidgetsFlutterBinding, runApp;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'core/config/theme/colors/logic/cubit/theme_cubit.dart' show ThemeCubit;
import 'core/config/theme/colors/logic/cubit/theme_shared_preferences.dart'
    show ThemeSharedPreferences;
import 'core/error/error_screen.dart' show errorScreen;
import 'core/routing/app_router.dart' show AppRouter;
import 'core/services/object_box_services/object_box_service.dart'
    show ObjectBoxService;
import 'core/shared_preferences_global/shared_preferences_global.dart';
import 'firebase_options.dart' show DefaultFirebaseOptions;
import 'tadamon.dart' show TadamonApp;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await SharedPreferencesGlobal().initialize();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await ObjectBoxService.init();

  final themeCubit = ThemeCubit(
    themeSharedPreferences: ThemeSharedPreferences(),
  );

  // await FirebaseAppCheck.instance.activate(
  //   androidProvider: AndroidProvider.playIntegrity,
  // );

  errorScreen();
  runApp(BlocProvider.value(value: themeCubit, child: TadamonApp(AppRouter())));
}
