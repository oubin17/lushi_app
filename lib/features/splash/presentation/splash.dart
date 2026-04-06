import 'package:flutter/material.dart';
import 'package:lushi_app/core/constants/images/app_images.dart';
import 'package:lushi_app/features/auth/domain/auth_service.dart';
import 'package:lushi_app/features/auth/presentation/login_or_regist.dart';
import 'package:lushi_app/features/home/presentation/home.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppImages.splash,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }

  Future<bool> _checkAutoLogin() async {
    return await AuthService().isLoggedIn();
  }

  Future<void> _redirect() async {
    await Future.delayed(const Duration(seconds: 2));
    final isLogged = await _checkAutoLogin();
    if (isLogged) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginOrRegistPage()),
      );
    }
  }
}
