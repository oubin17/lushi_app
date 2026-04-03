import 'package:flutter/material.dart';
import 'package:lushi_app/core/storage/storage_manager.dart';
import 'package:lushi_app/features/auth/data/models/userlogin_response.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserLoginResponse? userLoginResponse = StorageManager().getObject(
      'userInfo',
      (json) => UserLoginResponse.fromJson(json),
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.home, size: 64, color: Colors.blue),
          const SizedBox(height: 16),
          const Text('首页内容', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          Text('欢迎回来: ${userLoginResponse?.userId ?? "未知用户"}'),
        ],
      ),
    );
  }
}
