import 'package:flutter/material.dart';
import 'package:tadamon/core/error/no_routes.dart';
import 'package:tadamon/core/routing/routes.dart';
import 'package:tadamon/features/pages/app_info_page/ui/page/app_info.dart';
import 'package:tadamon/features/pages/chat_with_dev_page/ui/page/chat_with_dev.dart';
import 'package:tadamon/features/pages/help_user_page/ui/page/help_user_page.dart';
import 'package:tadamon/features/pages/main_page/ui/page/main_page.dart';
import 'package:tadamon/features/pages/onboarding_page/ui/page/onboarding_page.dart';
import 'package:tadamon/features/pages/palestine_map_page/ui/page/palestine_map_page.dart';
import 'package:tadamon/features/pages/terms_gate_page/terms_gate.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static ColorScheme get theme {
    final context = navigatorKey.currentContext;
    if (context == null) {
      throw Exception("Navigator context is not available");
    }
    return Theme.of(context).colorScheme;
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case Routes.onBoarding:
        page = const OnboardingPage();
        break;
      case Routes.termsGate:
        page = const TermsGate();
        break;
      case Routes.mainPage:
        page = const MainPage();
        break;
      case Routes.palatineMap:
        page = const PalestineMapPage();
        break;
      case Routes.userHelp:
        page = const HelpUserPage();
        break;
      case Routes.chatWithDev:
        page = const ChatWithDev();
      case Routes.appInfo:
        page = const AppInfo();
      default:
        page = const NoRoutes();
    }
    return _createPageRoute(page);
  }

  /// Creates a [PageRouteBuilder] with custom animations for the given [page].
  ///
  /// The transition includes a fade and slide effect, with the slide starting
  /// from the right edge of the screen. The transition duration is set to
  /// 200 milliseconds.

  PageRouteBuilder _createPageRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (_, animation, __) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: page,
        ),
      ),
    );
  }
}
