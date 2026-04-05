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
  void initState() async {
    super.initState();

    _projectInfoStatisticsResponse = await _getProjectInfoStatistics();
    _projectInfoList = await _getProjectInfo();
  }

  /// 获取项目列表
  Future<List<ProjectInfo>> _getProjectInfo() async {
    return await HomeResumeService().getProjectInfo();
  }

  /// 获取项目统计信息
  Future<ProjectInfoStatisticsResponse> _getProjectInfoStatistics() async {
    return await HomeResumeService().getProjectInfoStatistics();
  }

  // 刷新回调方法
  Future<void> _onRefresh() async {
    // 模拟网络请求延迟 2 秒
    await Future.delayed(const Duration(seconds: 1));

    // 在这里调用你的数据刷新逻辑
    _projectInfoStatisticsResponse = await _getProjectInfoStatistics();
    _projectInfoList = await _getProjectInfo();
    // await HomeResumeService().refreshData();

    // 结束刷新
    if (mounted) {
      setState(() {});
    }
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
                child: const Text('指标列表', style: TextStyle(fontSize: 20)),
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
                padding: const EdgeInsets.only(
                  top: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                alignment: Alignment.centerLeft,
                child: const Text('项目列表', style: TextStyle(fontSize: 20)),
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
