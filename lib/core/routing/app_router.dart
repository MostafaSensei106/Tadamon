import 'package:flutter/material.dart'
    show
        GlobalKey,
        NavigatorState,
        ColorScheme,
        RouteSettings,
        Route,
        Widget,
        PageRouteBuilder,
        Offset,
        Theme,
        Tween,
        SlideTransition,
        FadeTransition;

import '../../features/pages/app_info_page/ui/page/app_info.dart' show AppInfo;
import '../../features/pages/chat_with_dev_page/ui/page/chat_with_dev.dart'
    show ChatWithDev;
import '../../features/pages/help_user_page/ui/page/help_user_page.dart'
    show HelpUserPage;
import '../../features/pages/main_page/ui/page/main_page.dart' show MainPage;
import '../../features/pages/onboarding_page/ui/page/onboarding_page.dart'
    show OnboardingPage;
import '../../features/pages/palestine_map_page/ui/page/palestine_map_page.dart'
    show PalestineMapPage;
import '../../features/pages/terms_gate_page/terms_gate.dart' show TermsGate;
import '../error/no_routes.dart' show NoRoutes;
import 'routes.dart' show Routes;

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static ColorScheme get theme {
    final context = navigatorKey.currentContext;
    if (context == null) {
      throw Exception('Navigator context is not available');
    }
    return Theme.of(context).colorScheme;
  }

  Route<dynamic> generateRoute(final RouteSettings settings) {
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

  PageRouteBuilder _createPageRoute(final Widget page) => PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (_, final animation, _) => FadeTransition(
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
