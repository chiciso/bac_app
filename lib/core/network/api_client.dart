import 'package:dio/dio.dart';
import 'api_interceptors.dart';

class ApiClient {
  late Dio dio;

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.yourdomain.com/v1', // You will change this later
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      ),
    );

    // Add the interceptors we built earlier for logging and errors
    dio.interceptors.add(ApiInterceptors());
  }

  // A generic GET request helper
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException e) {
    // This is where you translate technical errors into human messages
    if (e.type == DioExceptionType.connectionTimeout) return "Connection timed out";
    return "Something went wrong. Please try again.";
  }
}