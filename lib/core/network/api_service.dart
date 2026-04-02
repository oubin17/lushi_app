import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:lushi_app/core/constants/base_constants.dart';
import 'package:lushi_app/models/response/service_response.dart';

class ApiService {
  // 单例实例
  static ApiService? _instance;

  final Dio _dio;

  // 获取单例实例的方法
  static ApiService get instance {
    _instance ??= ApiService._internal();
    return _instance!;
  }

  // 私有构造函数
  ApiService._internal({String? baseUrl, Map<String, dynamic>? customHeaders})
    : _dio = Dio(
        BaseOptions(
          // 默认使用 BaseConstants.baseUrl，也可以自定义
          baseUrl: baseUrl ?? BaseConstants.baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          // 自动合并公共请求头和自定义请求头
          headers: {
            ...BaseConstants.commonHeaders,
            if (customHeaders != null) ...customHeaders,
          },
        ),
      ) {
    // 添加请求拦截器
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (kDebugMode) {
            print('请求 URL: ${options.uri}');
            print('请求头：${options.headers}');
            print('请求体：${options.data}');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            print('响应状态: ${response.statusCode}');
            print('响应数据: ${response.data}');
          }
          return handler.next(response);
        },
        onError: (error, handler) {
          if (kDebugMode) {
            print('请求错误: ${error.message}');
            if (error.response != null) {
              print('错误响应: ${error.response?.data}');
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  // 保留公开构造函数用于测试或特殊场景
  factory ApiService({String? baseUrl, Map<String, dynamic>? customHeaders}) {
    return ApiService._internal(baseUrl: baseUrl, customHeaders: customHeaders);
  }

  Future<ServiceResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio
        .get(path, queryParameters: queryParameters)
        .then((response) => ServiceResponse.fromJson(response.data));
  }

  Future<ServiceResponse> post(String path, dynamic data) async {
    return await _dio
        .post(path, data: data)
        .then((response) => ServiceResponse.fromJson(response.data));
  }

  Future<ServiceResponse> put(String path, dynamic data) async {
    return await _dio
        .put(path, data: data)
        .then((response) => ServiceResponse.fromJson(response.data));
  }

  Future<ServiceResponse> delete(String path) async {
    return await _dio
        .delete(path)
        .then((response) => ServiceResponse.fromJson(response.data));
  }
}
