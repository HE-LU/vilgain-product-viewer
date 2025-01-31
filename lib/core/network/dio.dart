import 'package:dio/dio.dart';
import 'package:product_viewer/core/flogger.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

class DioService {
  DioService()
      : _instance = Dio(
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

  final Dio _instance;

  Dio get instance => _instance;
}
