import 'package:dio/dio.dart';
import '../main.dart';

class DioClient {
  DioClient._internal();

  static final DioClient _instance = DioClient._internal();

  factory DioClient() {
    return _instance;
  }

  late Dio dio;

  void create() {
    dio = Dio(BaseOptions(
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
    ));
    dio.interceptors.add(ApiInterceptors());
    talker.debug("[DIO] Created");
  }

  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    final response = await dio.get(path, queryParameters: queryParameters);
    talker.debug(response.runtimeType);
    return response.data;
  }
}

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _requestLog(options);
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _responseLog(response);
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _errorLog(err);
    return handler.next(err);
  }

  void _requestLog(RequestOptions options) {
    talker.log("[DIO REQUEST][PROCESS]${options.path}");
  }

  void _responseLog(Response response) {
    talker.info("[DIO REQUEST][SUCCESS]");
  }

  void _errorLog(DioException err) {
    talker.warning("[DIO REQUEST][FAIL]${err.message}");
  }
}
