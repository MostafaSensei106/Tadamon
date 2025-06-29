import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/services.dart' show SystemChrome, DeviceOrientation;
import 'package:flutter/widgets.dart' show WidgetsFlutterBinding, runApp;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:tadamon/core/config/theme/colors/logic/cubit/theme_cubit.dart'
    show ThemeCubit;
import 'package:tadamon/core/config/theme/colors/logic/cubit/theme_shared_preferences.dart'
    show ThemeSharedPreferences;
import 'package:tadamon/core/error/error_screen.dart' show errorScreen;
import 'package:tadamon/core/routing/app_router.dart' show AppRouter;
import 'package:tadamon/core/services/object_box_services/object_box_service.dart'
    show ObjectBoxService;
import 'package:tadamon/features/report_products/logic/services/report_service.dart'
    show ReportService;
import 'package:tadamon/firebase_options.dart' show DefaultFirebaseOptions;
import 'package:tadamon/tadamon.dart' show TadamonApp;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await ObjectBoxService.init();

  final themeCubit = ThemeCubit(
    themeSharedPreferences: ThemeSharedPreferences(),
  );

  // await FirebaseAppCheck.instance.activate(
  //   androidProvider: AndroidProvider.playIntegrity,
  // );

  errorScreen();
  ReportService.initializePreferences();
  runApp(BlocProvider.value(value: themeCubit, child: TadamonApp(AppRouter())));
}
