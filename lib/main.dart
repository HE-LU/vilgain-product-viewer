import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:product_viewer/app/app.dart';
import 'package:product_viewer/common/data/dto/product_storage_dto.dart';
import 'package:product_viewer/core/di/get_it.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// Preserve Splash. Splash is then removed on [LandingPage]
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Title: Setup LocalStorage
  // TODO: Move this to a separate file
  Hive.init((await getApplicationSupportDirectory()).path);
  Hive.registerAdapter(ProductStorageDTOImplAdapter());

  // Title: Setup DI
  await setupDependencyInjection();

  App.startApp();
}
