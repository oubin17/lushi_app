import 'package:lushi_app/core/network/api_service.dart';
import 'package:lushi_app/core/utils/log_utils.dart';
import 'package:lushi_app/features/auth/data/models/userlogin_request.dart';
import 'package:lushi_app/features/auth/data/models/userlogin_response.dart';
import 'package:lushi_app/models/response/service_response.dart';

class AuthApi {
  final ApiService _apiService = ApiService.instance;

  Future<UserLoginResponse?> login(UserLoginRequest request) async {
    try {
      ServiceResponse response = await _apiService.post('/user/login', {
        'loginId': request.loginId,
        'identifyValue': request.identifyValue,
        "loginType": request.loginType,
        "identifyType": request.identifyType,
      });

      if (response.data == null) {
        return null;
      }

      return UserLoginResponse.fromJson(response.data as Map<String, dynamic>);
    } catch (e, stackTrace) {
      Log.e('🚨 [AuthApi] 登录失败: $e, $stackTrace');
      rethrow;
    }
  }
}
