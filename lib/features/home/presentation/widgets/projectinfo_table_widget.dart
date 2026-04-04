import 'package:flutter/material.dart';
import 'package:lushi_app/features/home/data/models/project_info.dart';
import 'package:lushi_app/features/home/data/models/project_urgency_level.dart';
import 'package:lushi_app/features/home/domain/home_resume_service.dart';

class ProjectInfoTableWidget extends StatefulWidget {
  const ProjectInfoTableWidget({super.key});

  @override
  State<ProjectInfoTableWidget> createState() => _ProjectInfoTableWidgetState();
}

class _ProjectInfoTableWidgetState extends State<ProjectInfoTableWidget> {
  List<ProjectInfo>? projectInfoList;

  // 加载状态
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getProjectInfo();
  }

  /// 获取项目列表
  void _getProjectInfo() async {
    // 模拟网络延迟
    // await Future.delayed(const Duration(seconds: 1));

    // _isLoading = true;
    projectInfoList = await HomeResumeService().getProjectInfo();
    _isLoading = false;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : projectInfoList?.isEmpty ?? true
          ? const Center(child: Text('暂无项目信息...'))
          : _buildTable(),
    );
  }

  // 3. 构建表格 UI
  Widget _buildTable() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ClipRRect(
        // 让表格内容也遵循圆角裁剪
        borderRadius: BorderRadius.circular(12),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(2), // 产品名 占 2 份
            1: FlexColumnWidth(1.5), // 日期 占 1.5 份
            2: FlexColumnWidth(0.5), // 状态 占 1 份
            3: FlexColumnWidth(1),
          },
          border: TableBorder.all(color: Colors.grey[200]!), // 内部边框颜色
          children: [
            // 表头
            _buildTableRow(["项目名称", "公司", "人数", "紧急程度"], isHeader: true),
            // 数据行
            ...projectInfoList?.map(
                  (order) => _buildTableRow([
                    order.projectName,
                    order.company,
                    order.headCount.toString(),
                    ProjectUrgencyLevelExtension.fromValue(
                          int.parse(order.urgencyLevel),
                        )?.name ??
                        "",
                  ], isHeader: false),
                ) ??
                [],
          ],
        ),
      ),
    );
  }

  // 4. 构建单行（复用代码）
  TableRow _buildTableRow(List<String> cells, {required bool isHeader}) {
    return TableRow(
      // 斑马纹效果：偶数行背景色略深
      decoration: BoxDecoration(
        color: isHeader
            ? Colors.blueGrey[50]
            : (cells.hashCode.isEven ? Colors.white : Colors.grey[50]),
      ),
      children: cells.map((text) {
        // 状态标签样式处理
        if (text == "level_1") return _buildStatusBadge("紧急", Colors.red);
        if (text == "level_2") return _buildStatusBadge("重要", Colors.orange);
        if (text == "level_3") return _buildStatusBadge("一般", Colors.blue);
        if (text == "level_4") return _buildStatusBadge("不重要", Colors.green);
        if (text == "level_5") return _buildStatusBadge("不紧急", Colors.green);

        // 普通文本样式
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            text,
            style: TextStyle(
              color: isHeader ? Colors.blueGrey[800] : Colors.black87,
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        );
      }).toList(),
    );
  }

  // 5. 状态胶囊组件
  Widget _buildStatusBadge(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(45),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
