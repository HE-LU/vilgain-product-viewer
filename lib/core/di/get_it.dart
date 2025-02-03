import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:product_viewer/common/usecase/get_products_list_api_use_case.dart';
import 'package:product_viewer/common/usecase/get_products_list_storage_use_case.dart';
import 'package:product_viewer/common/usecase/put_products_list_storage_use_case.dart';
import 'package:product_viewer/core/flogger.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  // Title: Dio
  getIt.registerLazySingleton<Dio>(() => _getDioInstance());

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

Dio _getDioInstance() => Dio(
      BaseOptions(
        baseUrl: 'https://fakestoreapi.com', // Replace with your API base URL
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    )..interceptors.addAll([
        TalkerDioLogger(
          talker: Flogger.talker,
          settings: TalkerDioLoggerSettings(
            printRequestHeaders: false,
            printResponseHeaders: false,
            printResponseMessage: true,
            requestPen: Flogger.colors['httpRequest'],
            responsePen: Flogger.colors['httpResponse'],
            errorPen: Flogger.colors['httpError'],
          ),
        ),
      ]);
