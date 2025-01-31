import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:product_viewer/app/navigation/app_router.dart';
import 'package:product_viewer/app/navigation/app_router_service.dart';
import 'package:product_viewer/common/usecase/get_products_list_use_case.dart';
import 'package:product_viewer/core/network/dio.dart';

final GetIt getIt = GetIt.instance;

void setupDependencyInjection() {
  // Title: AppRouter
  getIt.registerLazySingleton<AppRouter>(() => AppRouterService().instance);

  // Title: Dio
  getIt.registerLazySingleton<Dio>(() => DioService().instance);

  // Title: UseCase
  getIt.registerFactory<GetProductsListUseCase>(() => GetProductsListUseCase(getIt<Dio>()));
}
