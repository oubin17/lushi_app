import 'package:dio/dio.dart';
import 'package:lushi_app/core/utils/log_utils.dart';

class RequestResponseInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Log.i(
    //   '${options.method} ${options.uri} ${options.data}',
    //   tag: 'Network-REQ',
    // );
    Log.i('${options.method} ${options.uri} ', tag: 'Network-REQ');
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Log.i(
    //   '${response.statusCode} ${response.requestOptions.uri} ${response.data}',
    //   tag: 'Network-RES',
    // );
    Log.i(
      '${response.statusCode} ${response.requestOptions.uri}',
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
