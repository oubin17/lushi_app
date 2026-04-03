import 'package:flutter/material.dart';
import 'package:lushi_app/core/storage/storage_manager.dart';
import 'package:lushi_app/features/auth/presentation/welcome.dart';

void main() async {
  // 确保 Flutter 引擎绑定初始化
  WidgetsFlutterBinding.ensureInitialized();

  // 1. 初始化普通存储
  await StorageManager.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: '禄仕人力管理系统',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: const Welcome(),
    );
  }
}
