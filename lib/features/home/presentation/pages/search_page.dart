import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 64, color: Colors.orange),
          SizedBox(height: 16),
          Text('搜索页面', style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
