import 'dart:io' show Platform;

class BaseConstants {
  // 开发环境 - Mac 的 IP 地址（根据你的网络环境修改）
  static const String _devIp = '192.168.31.228';

  // 根据平台自动选择正确的 baseUrl
  static String get baseUrl {
    // iOS 模拟器或真机
    if (Platform.isIOS) {
      return 'http://$_devIp:8080/odk-base-template/api';
    }

    // Android 模拟器
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080/odk-base-template/api';
    }

    // Web、macOS、Windows、Linux
    return 'http://localhost:8080/odk-base-template/api';
  }

  // 公共请求头
  static const Map<String, dynamic> commonHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-TENANT-ID': 'DEFAULT',
    // 可以在这里添加其他公共请求头，例如：
    // 'Platform': 'mobile',
    // 'Version': '1.0.0',
  };
}
