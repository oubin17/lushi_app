import 'package:flutter/material.dart';
import 'package:lushi_app/features/home/data/models/project_info.dart';
import 'package:lushi_app/features/home/data/models/projectinfo_statistics_response.dart';
import 'package:lushi_app/features/home/domain/home_resume_service.dart';
import 'package:lushi_app/features/home/presentation/widgets/projectinfo_gridview_widget.dart';
import 'package:lushi_app/features/home/presentation/widgets/projectinfo_table_widget.dart';
import 'package:lushi_app/widgets/appbar/app_bar.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  /// 项目统计信息
  ProjectInfoStatisticsResponse? _projectInfoStatisticsResponse;
  List<ProjectInfo>? _projectInfoList;

  @override
  void initState() {
    super.initState();

    _loadAllData();
  }

  // 加载状态（可选，用于显示加载中）
  bool _isLoading = true;

  // 2. 封装一个统一加载数据的方法
  Future<void> _loadAllData() async {
    // 可以在这里设置加载状态
    setState(() {
      _isLoading = true;
    });

    try {
      // 3. 使用 await 等待数据返回，然后再赋值给变量
      final stats = await HomeResumeService().getProjectInfoStatistics();
      final list = await HomeResumeService().getProjectInfo();

      // 4. 数据回来后，更新状态
      if (mounted) {
        setState(() {
          _projectInfoStatisticsResponse = stats;
          _projectInfoList = list;
          _isLoading = false;
        });
      }
    } catch (e) {
      // 处理错误
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // 刷新回调方法
  Future<void> _onRefresh() async {
    // 在这里调用你的数据刷新逻辑
    await _loadAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(title: const Text('首页')),
      // 使用 RefreshIndicator 包裹 CustomScrollView
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: Colors.blue,
        child: CustomScrollView(
          slivers: [
            // 1. 指标列表标题
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16.0), // 将 Padding 移入这里
                alignment: Alignment.centerLeft,
                child: const Text(
                  '指标列表',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // 2. 分割线
            const SliverToBoxAdapter(child: Divider(height: 1, thickness: 1)),
            // 3. 指标网格 (ProjectInfoGridViewWidget)
            // 注意：如果 ProjectInfoGridViewWidget 内部已经是 GridView，
            // 这里建议将其改为 SliverGrid 以获得更好的性能，或者直接包裹在 SliverToBoxAdapter 中
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ProjectInfoGridViewWidget(
                  projectInfoStatisticsResponse: _projectInfoStatisticsResponse,
                ),
              ),
            ),
            // 4. 项目列表标题
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.centerLeft,
                child: const Text(
                  '项目列表',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // 5. 分割线
            const SliverToBoxAdapter(child: Divider(height: 1, thickness: 1)),
            // 6. 项目表格 (ProjectInfoTableWidget)
            // 假设 ProjectInfoTableWidget 是一个 ListView
            // 如果它内部是 ListView，建议直接在这里构建 SliverList，或者确保它禁用了内部滚动
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ProjectInfoTableWidget(
                  projectInfoList: _projectInfoList,
                ),
              ),
            ),
            // 7. 底部留白，防止内容被底部遮挡
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }
}
