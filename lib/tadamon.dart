import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/theme/colors/dark_theme.dart';
import 'package:tadamon/core/config/theme/colors/light_theme.dart';
import 'package:tadamon/core/config/theme/colors/logic/cubit/theme_cubit.dart';
import 'package:tadamon/core/config/theme/colors/logic/cubit/theme_shared_preferences.dart';
import 'package:tadamon/core/config/theme/colors/logic/cubit/theme_state.dart';
import 'package:tadamon/core/routing/app_router.dart';
import 'package:tadamon/core/routing/routes.dart';
import 'package:toastification/toastification.dart';
import 'generated/l10n.dart';

class TadamonApp extends StatelessWidget {
  final AppRouter appRouter = AppRouter();
  TadamonApp(AppRouter appRouter, {super.key});
  
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: BlocProvider(
        lazy: true,
        create: (context) => ThemeCubit(
            themeSharedPreferences: ThemeSharedPreferences(), context: context)
          ..initializeTheme(),
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            return ToastificationWrapper(
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: ' تَضَامُنٌ',
                theme: lightTheme,
                darkTheme: darkTheme,
                navigatorKey: AppRouter.navigatorKey,
                themeMode: themeState.themeMode,
                initialRoute: Routes.onBoarding,
                onGenerateRoute: appRouter.generateRoute,
                themeAnimationCurve: Curves.easeInOut,
                locale: const Locale('ar', 'EG'),
                supportedLocales: const [
                  Locale('ar', 'EG'),
                ],
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                localeResolutionCallback: (locale, supportedLocales) =>
                    const Locale('ar', 'EG'),
                builder: (context, child) {
                  return SafeArea(
                    top: false,
                    bottom: true,
                    left: false,
                    right: false,
                    child: child!,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
