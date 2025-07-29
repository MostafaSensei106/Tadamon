import 'package:flutter/material.dart' show MaterialApp;
import 'package:flutter/widgets.dart'
    show StatelessWidget, BuildContext, Widget, Size, Locale, SafeArea;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;
import 'package:flutter_localizations/flutter_localizations.dart'
    show
        GlobalMaterialLocalizations,
        GlobalWidgetsLocalizations,
        GlobalCupertinoLocalizations;
import 'package:flutter_screenutil/flutter_screenutil.dart' show ScreenUtilInit;

import 'core/config/theme/colors/dark_theme.dart' show darkTheme;
import 'core/config/theme/colors/light_theme.dart' show lightTheme;
import 'core/config/theme/colors/logic/cubit/theme_cubit.dart' show ThemeCubit;
import 'core/config/theme/colors/logic/cubit/theme_state.dart' show ThemeState;
import 'core/routing/app_router.dart' show AppRouter;
import 'core/routing/routes.dart' show Routes;
import 'generated/l10n.dart' show S;

class TadamonApp extends StatelessWidget {
  // ignore: avoid_unused_constructor_parameters
  TadamonApp(final AppRouter appRouter, {super.key});
  final AppRouter appRouter = AppRouter();

  @override
  Widget build(final BuildContext context) => ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    child: BlocBuilder<ThemeCubit, ThemeState>(
      builder: (final context, final themeState) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'تَضَامُنٌ',
        theme: lightTheme,
        darkTheme: darkTheme,
        navigatorKey: AppRouter.navigatorKey,
        themeMode: themeState.themeMode,
        initialRoute: Routes.onBoarding,
        onGenerateRoute: appRouter.generateRoute,
        locale: const Locale('ar', 'EG'),
        supportedLocales: const [Locale('ar', 'EG')],
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (final locale, final supportedLocales) =>
            const Locale('ar', 'EG'),
        builder: (final context, final child) =>
            SafeArea(top: false, left: false, right: false, child: child!),
      ),
    ),
  );
}
