import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageManager {
  static final SecureStorageManager _instance =
      SecureStorageManager._internal();

  factory SecureStorageManager() => _instance;

  SecureStorageManager._internal();

  // 配置 Android 选项 (可选，针对 Android 18+ 需要配置)
  static const AndroidOptions _androidOptions = AndroidOptions(
    encryptedSharedPreferences: true, // 启用加密共享偏好设置
  );

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: _androidOptions,
  );

  /// 保存数据 (异步)
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// 读取数据 (异步)
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  /// 删除指定 key
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  /// 清空所有安全数据
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  Future<T?> getObject<T>(
    String key,
    T Function(Map<String, dynamic>) fromJsonFunc,
  ) async {
    final jsonString = await read(key);
    if (jsonString == null) {
      return null;
    }

    final Map<String, dynamic> map =
        jsonDecode(jsonString) as Map<String, dynamic>;

    // 调用传入的转换函数
    return fromJsonFunc(map);
  }
}
