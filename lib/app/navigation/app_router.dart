import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:product_viewer/data/model/product_model.dart';
import 'package:product_viewer/features/dashboard/dashboard_page.dart';
import 'package:product_viewer/features/landing/landing_page.dart';
import 'package:product_viewer/features/product_detail/product_detail_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        // Subtitle: Landing Route
        CustomRoute(
          page: LandingRoute.page,
          initial: true,
          // We don't really need to animate landing page, because
          // it doesn't have UI, it's covered by splash screen.
          durationInMilliseconds: 0,
        ),

        // Subtitle: Dashboard Route
        AutoRoute(page: DashboardRoute.page),

        // Subtitle: Product Detail Route
        AutoRoute(page: ProductDetailRoute.page),
      ];
}
