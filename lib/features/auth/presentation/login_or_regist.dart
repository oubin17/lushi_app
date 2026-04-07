import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lushi_app/core/constants/images/app_images.dart';
import 'package:lushi_app/features/auth/data/models/userlogin_request.dart';
import 'package:lushi_app/features/auth/domain/auth_service.dart';
import 'package:lushi_app/models/entities/user_entity.dart';
import 'package:lushi_app/routes/navigator_utils.dart';
import 'package:lushi_app/widgets/appbar/app_bar.dart';
import 'package:lushi_app/widgets/button/basic_app_button.dart';

class LoginOrRegistPage extends StatelessWidget {
  const LoginOrRegistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const InnerLoginPage(title: '用户登录');
  }
}

class InnerLoginPage extends StatefulWidget {
  const InnerLoginPage({super.key, required this.title});

  final String title;

  @override
  State<InnerLoginPage> createState() => _InnerLoginPageState();
}

class _InnerLoginPageState extends State<InnerLoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        // title: SvgPicture.asset(AppImages.logoBg, height: 80),
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Center(
            child: SvgPicture.asset(
              AppImages.logoBg,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // 背景图片
          // Image.asset(
          //   AppImages.authBg,
          //   fit: BoxFit.cover,
          //   width: double.infinity,
          //   height: double.infinity,
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 50.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  _emailField(context),
                  const SizedBox(height: 20),
                  _passwordField(context),
                  const Spacer(),
                  _registerButton(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],

        // Container(color: Colors.black.withOpacity(0.3)),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final UserEntity? userEntity = await AuthService().login(
        UserLoginRequest(
          loginId: _emailController.text,
          identifyValue: _passwordController.text,
        ),
      );
      if (userEntity != null) {
        // 登录成功，导航到首页
        NavigatorUtils.go('/home');
      }
    }
  }

  Widget _emailField(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.app_registration),
        labelText: '账号',
      ),
      // style: const TextStyle(fontSize: 16),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '请输入账号';
        }
        return null;
      },
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      decoration: const InputDecoration(
        labelText: '密码',
        prefixIcon: Icon(Icons.password),
      ),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '请输入密码';
        }
        return null;
      },
    );
  }

  Widget _registerButton() {
    return BasicAppButton(onPressed: () => _login(), title: '登录');
  }
}
