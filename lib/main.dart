import 'package:flutter/material.dart';
import 'package:lushi_app/features/auth/presentation/login_or_regist.dart';
import 'package:lushi_app/features/auth/presentation/welcome.dart';

void main() {
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
