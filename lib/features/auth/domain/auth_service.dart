import 'dart:convert';

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
import 'package:lushi_app/models/entities/user_entity.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  AuthService._internal();
  factory AuthService() => _instance;

  /// 登录方法，返回用户 ID
  ///
  /// 异常处理说明:
  /// - [AppException] - 网络错误或服务器业务错误，包含明确的错误类型和消息
  Future<UserEntity?> login(UserLoginRequest request) async {
    // 直接调用 API，让异常自然向上传递
    request.identifyValue = await EncryptUtils.encrypt(request.identifyValue);

    // 拦截器已经统一处理了所有异常
    UserLoginResponse? response = await AuthApi().login(request);
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
      UserEntity userEntity = await getUserInfo();
      await SecureStorageManager().write(
        StorageKey.userInfo,
        jsonEncode(userEntity.toJson()),
      );

      // await StorageManager().setJson(StorageKey.userInfo, response.toJson());
      return userEntity;
    }
  }

  /// 登录方法，返回用户 ID
  ///
  /// 异常处理说明:
  /// - [AppException] - 网络错误或服务器业务错误，包含明确的错误类型和消息
  Future<void> logout() async {
    // 拦截器已经统一处理了所有异常
    await AuthApi().logout();

    await afterLogout();
    //1.删除 token
    // await SecureStorageManager().deleteAll();
    // await SecureStorageManager().delete(StorageKey.token);
    //2.删除用户信息
    // await StorageManager().remove(StorageKey.userInfo);
    //3.删除本地缓存
    // await StorageManager().clear();
  }

  Future<void> afterLogout() async {
    await SecureStorageManager().deleteAll();
    await StorageManager().clear();
  }

  /// 检查用户是否已登录
  Future<bool> isLoggedIn() async {
    // 读取加密存储中的 token
    final token = await SecureStorageManager().read(StorageKey.token);
    // 不为空且不为空字符串，说明已登录
    return token != null && token.isNotEmpty;
  }

  /// 获取本地用户信息
  Future<UserEntity?> getLocalUserInfo() async {
    final String? userInfo = await SecureStorageManager().read(
      StorageKey.userInfo,
    );
    if (userInfo == null) {
      return getUserInfo();
    } else {
      return UserEntity.fromJson(jsonDecode(userInfo));
    }
  }

  /// 获取用户信息
  Future<UserEntity> getUserInfo() async {
    // 拦截器已经统一处理了所有异常
    UserEntity user = await AuthApi().getUserInfo();
    //1.存储用户信息
    await SecureStorageManager().write(
      StorageKey.userInfo,
      jsonEncode(user.toJson()),
    );

    return user;
  }
}
