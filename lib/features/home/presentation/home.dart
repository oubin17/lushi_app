import 'package:flutter/material.dart';
import 'package:lushi_app/features/home/presentation/pages/index_page.dart';
import 'package:lushi_app/features/home/presentation/pages/private_resume_page.dart';
import 'package:lushi_app/features/home/presentation/pages/profile_page.dart';
import 'package:lushi_app/features/home/presentation/pages/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const IndexPage(),
    const PrivateResumePage(),
    // const SearchPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,

        // 1. 核心：设置选中时的颜色
        selectedItemColor: Colors.deepPurpleAccent,

        // 2. 核心：设置未选中时的颜色
        unselectedItemColor: Colors.grey,

        // 3. 关键：固定模式，确保未选中时也显示文字
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          const BottomNavigationBarItem(
            icon: Icon(Icons.private_connectivity),
            label: '私有库',
          ),
          // const BottomNavigationBarItem(icon: Icon(Icons.search), label: '搜索'),
          const BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
        ],
      ),
    );
  }
}
