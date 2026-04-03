import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lushi_app/core/constants/images/app_images.dart';
import 'package:lushi_app/core/utils/log_utils.dart';
import 'package:lushi_app/features/auth/data/models/userlogin_request.dart';
import 'package:lushi_app/features/auth/domain/auth_service.dart';
import 'package:lushi_app/widgets/appbar/app_bar.dart';
import 'package:lushi_app/widgets/button/basic_app_button.dart';

class LoginOrRegist extends StatelessWidget {
  const LoginOrRegist({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: SvgPicture.asset(AppImages.logoBg, height: 40),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _registerText(),
            SizedBox(height: 20),
            _emailField(context),
            SizedBox(height: 20),
            _passwordField(context),
            Spacer(),
            _registerButton(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

Widget _registerText() {
  return Text(
    "用户登录",
    style: TextStyle(
      // color: Colors.white,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.center,
  );
}

Widget _emailField(BuildContext context) {
  return TextField(decoration: InputDecoration(hintText: '账号'));
}

Widget _passwordField(BuildContext context) {
  return TextField(decoration: InputDecoration(hintText: '密码'));
}

Widget _registerButton() {
  return BasicAppButton(onPressed: () {}, title: '登录');
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _login() async {
    // 直接使用单例
    final authService = AuthService();
    String password =
        'LAVeSZeyMXMTAu2e0aUJj3fa3j9QmTL9qBq5k9Nqq8i4eSPlk2Pq/7TCDNs3PyxOGsAQNsW3wbH51YDRlyn0whTxGgaeAPoOfW0/udazC8Kcmvg/n9a0NrcE7f+gHQyv1McndWT2q44On8fbJCd7BFQpu5iRxpzJg1mtWgJ7lwIDC6xj5L7Vtx+L1JaC2QdAfBEoxID/AcYuh86XfXiF+hOCt09D5wtUxPQLeMXsP+e7ypOq4Z04ReaQKz0fezaqbXbD79jy6dPMurexNf9ikKkY+8xFUcsHgg1b/w1pM2NVZa54Oiqaz09OPG289UAQnYRJ8rsRwKIhBXUskLxeJw==';
    String? userId = await authService.login(
      UserLoginRequest(loginId: '110', identifyValue: password),
    );
    Log.i('User ID: $userId', tag: 'Auth-Login');
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: _incrementCounter,
        onPressed: _login,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
