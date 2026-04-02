import 'package:lushi_app/core/network/api_service.dart';
import 'package:lushi_app/features/auth/data/models/userlogin_response.dart';
import 'package:lushi_app/models/response/service_response.dart';

class AuthApi {
  final ApiService _apiService = ApiService.instance;

  Future<UserLoginResponse> login(String loginId, String password) async {
    ServiceResponse<dynamic> response = await _apiService.post('/user/login', {
      'loginId': loginId,
      'identifyValue': password,
      "loginType": "1",
      "identifyType": "1",
    });
    return response.data! as UserLoginResponse;
  }
}
