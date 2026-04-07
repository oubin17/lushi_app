import 'package:flutter/material.dart';
import 'package:lushi_app/core/storage/storage_manager.dart';
import 'package:lushi_app/features/provider/data/model/counter_model.dart';
import 'package:lushi_app/routes/app_router.dart';
import 'package:provider/provider.dart';

void main() async {
  // 确保 Flutter 引擎绑定初始化
  WidgetsFlutterBinding.ensureInitialized();

  // 1. 初始化普通存储
  await StorageManager.init();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => CounterModel())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   navigatorKey: NavigatorUtils.navigatorKey,
    //   debugShowCheckedModeBanner: false,

    //   home: const SplashPage(),
    // );
    return MaterialApp.router(
      // 绑定路由配置
      routerConfig: AppRouter.router,
      // 关闭调试标识
      debugShowCheckedModeBanner: false,

      // 其他主题配置保留不变
      // theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
