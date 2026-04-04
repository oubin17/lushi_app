import 'package:flutter/material.dart';
import 'package:lushi_app/features/home/presentation/widgets/projectinfo_gridview_widget.dart';
import 'package:lushi_app/features/home/presentation/widgets/projectinfo_table_widget.dart';
import 'package:lushi_app/widgets/appbar/app_bar.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(title: const Text('首页')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // padding: const EdgeInsets.only(bottom: 16.0),
                alignment: Alignment.centerLeft,
                child: const Text('指标列表', style: TextStyle(fontSize: 20)),
              ),
              const Divider(height: 30), // 分割线
              ProjectInfoGridViewWidget(),
              Container(
                padding: const EdgeInsets.only(top: 16.0),
                alignment: Alignment.centerLeft,
                child: const Text('项目列表', style: TextStyle(fontSize: 20)),
              ),
              const Divider(height: 30), // 分割线
              ProjectInfoTableWidget(),

              const Icon(Icons.home, size: 64, color: Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}
