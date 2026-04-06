import 'package:flutter/material.dart';

/// 全局导航管理工具
class NavigatorUtils {
  /// 全局导航 Key，用于在没有 Context 的地方进行跳转
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// 获取当前的 Context
  static BuildContext? get currentContext => navigatorKey.currentContext;

  /// 获取当前的 State
  static NavigatorState? get currentState => navigatorKey.currentState;

  /// 跳转到欢迎页并清空路由栈
  static void pushReplacementPage(Widget page) {
    currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );
  }
}
