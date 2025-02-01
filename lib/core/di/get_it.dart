import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:product_viewer/app/navigation/app_router.dart';
import 'package:product_viewer/app/navigation/app_router_service.dart';
import 'package:product_viewer/common/usecase/get_products_list_api_use_case.dart';
import 'package:product_viewer/common/usecase/get_products_list_storage_use_case.dart';
import 'package:product_viewer/common/usecase/put_products_list_storage_use_case.dart';
import 'package:product_viewer/core/network/dio.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  // Title: AppRouter
  getIt.registerLazySingleton<AppRouter>(() => AppRouterService().instance);

  // Title: Dio
  getIt.registerLazySingleton<Dio>(() => DioService().instance);

  // Title: StorageService
  getIt.registerFactoryAsync<Box>(() => Hive.openBox('dashboardBox'), instanceName: 'dashboard');

  // Title: UseCase
  getIt.registerFactory<GetProductsListApiUseCase>(() => GetProductsListApiUseCase(getIt<Dio>()));
  getIt.registerFactoryAsync<GetProductsListStorageUseCase>(
    () async => GetProductsListStorageUseCase(await getIt.getAsync<Box>(instanceName: 'dashboard')),
  );
  getIt.registerFactoryAsync<PutProductsListStorageUseCase>(
    () async => PutProductsListStorageUseCase(await getIt.getAsync<Box>(instanceName: 'dashboard')),
  );
}
