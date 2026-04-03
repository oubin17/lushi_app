import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lushi_app/core/exceptions/app_exception.dart';
import 'package:lushi_app/core/storage/secure_storage_manager.dart';
import 'package:lushi_app/core/storage/storage_key.dart';
import 'package:lushi_app/core/storage/storage_manager.dart';
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
  Future<UserLoginResponse?> login(UserLoginRequest request) async {
    // 直接调用 API，让异常自然向上传递
    request.identifyValue = await EncryptUtils.encrypt(request.identifyValue);

    // 拦截器已经统一处理了所有异常
    UserLoginResponse? response = await authApi.login(request);
    if (response == null) {
      Fluttertoast.showToast(
        msg: "登录失败，请检查密码",
        toastLength: Toast.LENGTH_SHORT, // 短提示
        gravity: ToastGravity.CENTER, // 居中显示
        timeInSecForIosWeb: 1, // iOS/Web 显示时长
        backgroundColor: Colors.black54, // 背景色
        textColor: Colors.white, // 文字颜色
        fontSize: 16.0, // 字体大小
      );
      return null;
    } else {
      //1.存储 token
      await SecureStorageManager().write(
        StorageKey.token,
        response.token ?? '',
      );
      //2.存储用户信息
      response.token = '';
      //3.判断是否是管理员
      final adminRole = response.roles?.firstWhere(
        (element) => element.roleCode == "ADMIN",
      );
      response.isAdmin = adminRole != null ? "true" : "false";
      await StorageManager().setJson(StorageKey.userInfo, response.toJson());
      return response;
    }
  }

  /// 登录方法，返回用户 ID
  ///
  /// 异常处理说明:
  /// - [AppException] - 网络错误或服务器业务错误，包含明确的错误类型和消息
  Future<void> logout() async {
    // 拦截器已经统一处理了所有异常
    await authApi.logout();
    //1.删除 token
    await SecureStorageManager().delete(StorageKey.token);
    //2.删除用户信息
    // await StorageManager().remove(StorageKey.userInfo);
    //3.删除本地缓存
    await StorageManager().clear();
  }
}
