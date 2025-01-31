import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:product_viewer/app/navigation/app_router.dart';
import 'package:product_viewer/core/flogger.dart';

/// Landing page is a great place to do a few stuff before navigating into the app
///
/// These are the stuff that should be probably handled there:
/// - Check for force update - Not letting users into the app, preventing further data loading.
/// - Check if there is a user signed in - Authentication-based navigation
/// - Deeplink handling - Handle deeplink and navigate to the correct screen.
@RoutePage()
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<StatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();

    // We need to make sure that the Widget was build before using ref.
    WidgetsBinding.instance.addPostFrameCallback((_) => _handleLandingPageNavigation());
  }

  @override
  Widget build(BuildContext context) {
    // Just an empty scaffold, we don't need to show anything here.
    return Scaffold(body: const SizedBox());
  }

  Future<void> _handleLandingPageNavigation() async {
    if (mounted) {
      FlutterNativeSplash.remove();

      Flogger.d('[LandingPage] Redirecting to Dashboard');
      context.replaceRoute(DashboardRoute());
    }
  }
}
