import 'package:dio/dio.dart';
import 'package:lushi_app/core/constants/system/system_constants.dart';
import 'package:lushi_app/core/storage/secure_storage_manager.dart';
import 'package:lushi_app/core/storage/storage_key.dart';
import 'package:lushi_app/core/utils/log_utils.dart';

class RequestResponseInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Log.i(
    //   '${options.method} ${options.uri} ${options.data}',
    //   tag: 'Network-REQ',
    // );
    Log.i(
      '${options.method} ${options.uri} ${options.data} ${options.headers}',
      tag: 'Network-REQ',
    );

    // 从安全存储中异步读取 Token
    final token = await SecureStorageManager().read(StorageKey.token);

    if (token != null && token.isNotEmpty) {
      // 注入 Token 到请求头
      options.headers[SystemConstants.tokenHeader] = token;
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Log.i(
    //   '${response.statusCode} ${response.requestOptions.uri} ${response.data}',
    //   tag: 'Network-RES',
    // );
    Log.i(
      '${response.statusCode} ${response.requestOptions.uri} ${response.data}',
      tag: 'Network-RES',
    );

    if (response.statusCode != 200) {
      return handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: response.data,
          message: response.data['errorContext'] ?? '业务请求失败',
        ),
      );
    }
    // 检查业务逻辑是否成功
    final data = response.data;
    if (data is Map<String, dynamic> && data['success'] == false) {
      Log.w('业务逻辑失败: $data', tag: 'Network-ERR');
    }
    return handler.next(response);
  }
}
