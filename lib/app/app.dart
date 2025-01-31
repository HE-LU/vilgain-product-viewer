import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:product_viewer/app/navigation/app_router.dart';
import 'package:product_viewer/core/di/get_it.dart';
import 'package:product_viewer/core/flogger.dart';

class App extends StatelessWidget {
  App({super.key});

  static void startApp() {
    runApp(App());
  }

  final AppRouter _appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Product Viewer',
      themeMode: ThemeMode.system,
      routerConfig: _appRouter.config(
        navigatorObservers: () => [
          LogsRouteObserver(),
        ],
      ),
    );
  }
}

// TODO: Should be elsewhere and provided by DI
class LogsRouteObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    if (route.settings.name == null) return;
    Flogger.navigation('[Navigation] New route pushed: ${route.settings.name}');
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    Flogger.navigation('[Navigation] Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    Flogger.navigation('[Navigation] Tab route re-visited: ${route.name}');
  }
}
