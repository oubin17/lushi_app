import 'package:lushi_app/features/auth/data/api/auth_api.dart';
import 'package:lushi_app/features/auth/data/models/userlogin_response.dart';

class AuthService {
  final AuthApi authApi = AuthApi();

  // 登录方法，返回用户 ID
  Future<String> login(String loginId, String password) async {
    try {
      UserLoginResponse response = await authApi.login(loginId, password);
      return response.userId;
    } catch (e) {
      // 可以根据需要添加错误处理逻辑
      rethrow;
    }
  }
}
