import 'package:dio/dio.dart';
import 'package:lushi_app/core/constants/system/system_constants.dart';
import 'package:lushi_app/core/storage/secure_storage_manager.dart';
import 'package:lushi_app/core/storage/storage_key.dart';
import 'package:lushi_app/core/utils/log_utils.dart';
import 'package:lushi_app/core/utils/navigator_utils.dart';
import 'package:lushi_app/features/auth/domain/auth_service.dart';
import 'package:lushi_app/features/splash/presentation/splash.dart';

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

  /// 如果是 400，直接进入 onError 处理
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Log.e('成功捕获到上层抛出的异常！', tag: 'ErrorInterceptor', error: err.message);
    // 检查业务逻辑是否成功
    final data = err.response?.data;
    if (data is Map<String, dynamic> && data['success'] == false) {
      Log.w('业务逻辑失败: $data', tag: 'Network-ERR');
      //如果是 token 过期，直接跳到登录页
      List<String> tokenExpiredCodes = ['020', '021', '022'];
      final errorCode = data['errorCode'];
      if (tokenExpiredCodes.contains(errorCode)) {
        // 1. 清除本地存储
        AuthService().afterLogout();
        // 2. 跳转欢迎页
        NavigatorUtils.pushReplacementPage(const SplashPage());
      }
    }
  }
}
