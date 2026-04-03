import 'package:lushi_app/core/exceptions/app_exception.dart';
import 'package:lushi_app/core/utils/encrypt_utils.dart';
import 'package:lushi_app/features/auth/data/api/auth_api.dart';
import 'package:lushi_app/features/auth/data/models/userlogin_request.dart';
import 'package:lushi_app/features/auth/data/models/userlogin_response.dart';

class AuthService {
  final AuthApi authApi = AuthApi();

  /// 登录方法，返回用户 ID
  ///
  /// 异常处理说明:
  /// - [AppException] - 网络错误或服务器业务错误，包含明确的错误类型和消息
  Future<String?> login(UserLoginRequest request) async {
    // 直接调用 API，让异常自然向上传递
    request.identifyValue = await EncryptUtils.encrypt(request.identifyValue);

    // 拦截器已经统一处理了所有异常
    UserLoginResponse? response = await authApi.login(request);
    return response?.userId;
  }
}
