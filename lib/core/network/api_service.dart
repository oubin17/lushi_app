import 'package:dio/dio.dart';
import 'package:lushi_app/core/constants/base_constants.dart';
import 'package:lushi_app/core/exceptions/app_exception.dart';
import 'package:lushi_app/core/network/interceptors/request_response_interceptor.dart';
import 'package:lushi_app/core/utils/log_utils.dart';
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
    // 注意：Dio 的 onResponse/onError 是逆序执行的。
    // 为了让 ErrorInterceptor 能够捕获到 RequestResponseInterceptor 抛出的异常，
    // ErrorInterceptor 必须先于 RequestResponseInterceptor 被添加到拦截器列表中。
    // _dio.interceptors.add(ErrorInterceptor());
    _dio.interceptors.add(RequestResponseInterceptor());

    Log.i('拦截器初始化完毕，当前数量: ${_dio.interceptors.length}', tag: 'ApiService');
  }

  // 保留公开构造函数用于测试或特殊场景
  factory ApiService({String? baseUrl, Map<String, dynamic>? customHeaders}) {
    return ApiService._internal(baseUrl: baseUrl, customHeaders: customHeaders);
  }

  /// GET 请求
  /// 支持添加查询参数
  Future<ServiceResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return ServiceResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _unwrapException(e);
    }
  }

  /// POST 请求
  /// 支持添加请求体数据
  Future<ServiceResponse> post(String path, dynamic data) async {
    try {
      final response = await _dio.post(path, data: data);
      return ServiceResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _unwrapException(e);
    }
  }

  /// PUT 请求
  /// 支持添加请求体数据
  Future<ServiceResponse> put(String path, dynamic data) async {
    try {
      final response = await _dio.put(path, data: data);
      return ServiceResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _unwrapException(e);
    }
  }

  /// DELETE 请求
  /// 支持添加路径
  Future<ServiceResponse> delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return ServiceResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _unwrapException(e);
    }
  }

  Future<ServiceResponse> postWithQueryParameters(
    String path,
    Map<String, dynamic>? queryParameters,
    dynamic data,
  ) async {
    try {
      final response = await _dio.post(
        path,
        queryParameters: queryParameters,
        data: data,
      );
      return ServiceResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _unwrapException(e);
    }
  }

  /// 统一解包异常
  /// 如果 DioException 的 error 是 AppException，则直接抛出 AppException
  Exception _unwrapException(DioException e) {
    if (e.error is AppException) {
      return e.error as AppException;
    }
    return e;
  }
}
