class SystemConstants {
  //环境配置
  static const String environment = 'dev';

  // 公共请求头
  static const String tokenHeader = 'ODK-TOKEN';

  // 租户ID
  static const String tenantId = 'DEFAULT';

  static String get serverIp {
    // iOS 模拟器或真机
    switch (environment) {
      case 'dev':
        return '192.168.31.228';
      case 'test':
        return 'xxx';
      case 'prod':
        return 'xxx';
      default:
        return 'xxx';
    }
  }
}
