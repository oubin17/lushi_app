import 'package:flutter/material.dart';
import 'package:lushi_app/features/home/data/models/projectinfo_statistics_response.dart';
import 'package:lushi_app/features/home/domain/home_resume_service.dart';

class ProjectInfoGridViewWidget extends StatefulWidget {
  const ProjectInfoGridViewWidget({super.key});

  @override
  State<ProjectInfoGridViewWidget> createState() =>
      _ProjectInfoGridViewWidgetState();
}

class _ProjectInfoGridViewWidgetState extends State<ProjectInfoGridViewWidget> {
  /// 项目统计信息
  ProjectInfoStatisticsResponse? projectInfoStatisticsResponse;

  @override
  void initState() {
    super.initState();
    getProjectInfoStatistics();
  }

  /// 获取项目统计信息
  Future<void> getProjectInfoStatistics() async {
    projectInfoStatisticsResponse = await HomeResumeService()
        .getProjectInfoStatistics();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return // 使用 GridView 实现 2x2 布局
    GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.3, // 稍微降低比例，增加卡片高度
      children: [
        StatCard(
          title: "年度有效报道人数",
          value:
              projectInfoStatisticsResponse?.validReportCount.toString() ?? "0",
          icon: Icons.date_range,
          color: Colors.green,
        ),
        StatCard(
          title: "当月有效报道人数",
          value:
              projectInfoStatisticsResponse?.addReportCount.toString() ?? "0",
          icon: Icons.done_all,
          color: Colors.orange,
        ),
        StatCard(
          title: "当月新增简历数量",
          value: projectInfoStatisticsResponse?.reviewCount.toString() ?? "0",
          icon: Icons.add,
          color: Colors.blue,
        ),
        StatCard(
          title: "当日新增简历数量",
          value:
              projectInfoStatisticsResponse?.todayReviewCount.toString() ?? "0",
          icon: Icons.favorite,
          color: Colors.red,
        ),
      ],
    );
  }
}

// 封装好的统计卡片组件
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0), // 减小内边距
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 左侧图标背景
                Container(
                  padding: const EdgeInsets.all(6), // 减小图标容器内边距
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20), // 稍微减小图标大小
                ),
                Flexible(
                  // 使用 Flexible 防止标题过长导致横向溢出
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12), // 减小间距
            // 数值
            Text(
              value,
              style: const TextStyle(
                fontSize: 18, // 稍微减小字体
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
