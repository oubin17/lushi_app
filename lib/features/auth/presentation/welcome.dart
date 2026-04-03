import 'package:flutter/material.dart';
import 'package:lushi_app/core/constants/images/app_images.dart';
import 'package:lushi_app/features/auth/presentation/login_or_regist.dart';
import 'package:lushi_app/widgets/button/basic_app_button.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 背景图片
          Image.asset(
            AppImages.authBg,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Container(color: Colors.black.withOpacity(0.3)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            child: Column(
              children: [
                const SizedBox(height: 200),
                const Center(
                  child: Text(
                    '禄仕人力管理系统',
                    style: TextStyle(
                      fontSize: 28,
                      color: Color.fromARGB(255, 127, 144, 235),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                BasicAppButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const LoginOrRegist(),
                      ),
                    );
                  },
                  title: "登录",
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
