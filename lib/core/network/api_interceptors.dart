import 'dart:developer'; // Required for log()
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // Required for debugPrint()

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // debugPrint only works in debug mode and is safer than print
    debugPrint('NETWORK REQUEST[${options.method}] => PATH: ${options.path}');
    
    // Add logic to attach tokens here
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('NETWORK RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Use log() for errors to see the full stack trace without cluttering the UI console
    log('NETWORK ERROR[${err.response?.statusCode}]', 
        name: 'API_ERROR', 
        error: err.message);
        
    super.onError(err, handler);
  }
}