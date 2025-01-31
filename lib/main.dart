import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:product_viewer/app/app.dart';
import 'package:product_viewer/core/di/get_it.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// Preserve Splash. Splash is then removed on [LandingPage]
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Setup DI
  setupDependencyInjection();

  App.startApp();
}
