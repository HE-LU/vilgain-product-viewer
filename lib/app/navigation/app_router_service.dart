import 'package:product_viewer/app/navigation/app_router.dart';

class AppRouterService {
  AppRouterService() : _instance = AppRouter();

  final AppRouter _instance;

  AppRouter get instance => _instance;
}
