import 'package:flutter/material.dart';
import 'package:lushi_app/core/constants/images/app_images.dart';
import 'package:lushi_app/core/storage/storage_key.dart';
import 'package:lushi_app/core/storage/storage_manager.dart';
import 'package:lushi_app/features/auth/data/models/userlogin_response.dart';
import 'package:lushi_app/features/home/data/models/private_resume.dart';
import 'package:lushi_app/features/home/data/models/private_resume_status.dart';
import 'package:lushi_app/features/home/domain/home_resume_service.dart';

class PrivateResumeTableWidget extends StatefulWidget {
  const PrivateResumeTableWidget({super.key});

  @override
  State<PrivateResumeTableWidget> createState() =>
      _PrivateResumeTableWidgetState();
}

class _PrivateResumeTableWidgetState extends State<PrivateResumeTableWidget> {
  List<PrivateResumeInfo>? privateResumeInfoList;

  // 加载状态
  bool _isLoading = true;

  // 1. 添加一个 ScrollController (可选，但推荐用于复杂列表)
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _getPrivateResumeInfo();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// 获取隐私简历列表
  Future<void> _getPrivateResumeInfo() async {
    // 模拟网络延迟
    await Future.delayed(const Duration(seconds: 1));

    try {
      // 这里调用你的 Service
      privateResumeInfoList = await HomeResumeService().getPrivateResumeInfo();
    } catch (e) {
      // 处理错误
    } finally {
      // 无论成功失败，都结束加载状态
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// 下拉刷新触发的方法
  Future<void> _onRefresh() async {
    // 重置状态
    setState(() {
      _isLoading = true;
    });
    // 重新获取数据
    await _getPrivateResumeInfo();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: _isLoading && (privateResumeInfoList?.isEmpty ?? true)
          ? const Center(child: CircularProgressIndicator()) // 首次加载时的空状态
          : ListView.builder(
              controller: _scrollController, // 绑定控制器
              itemCount: privateResumeInfoList?.length ?? 0,
              itemBuilder: (context, index) {
                final privateResumeInfo = privateResumeInfoList![index];
                return PrivateResumeTableRowWidget(
                  privateResumeInfo: privateResumeInfo,
                );
              },
            ),
    );
  }
}

class PrivateResumeTableRowWidget extends StatelessWidget {
  const PrivateResumeTableRowWidget({
    super.key,
    required this.privateResumeInfo,
  });

  final PrivateResumeInfo privateResumeInfo;

  @override
  Widget build(BuildContext context) {
    UserLoginResponse? user = StorageManager().getObject(
      StorageKey.userInfo,
      (json) => UserLoginResponse.fromJson(json),
    );

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        radius: 28,
        backgroundImage: AssetImage(
          privateResumeInfo.resumeLibraryDTO?.gender == "1"
              ? AppImages.man
              : AppImages.woman,
        ),
      ),

      // --- 视觉优化 ---
      // 让点击时的水波纹变成圆角，且选中时有背景色
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(color: Colors.grey[200]!), // 底部边框分割线
      ),
      selectedTileColor: Colors.blue[50], // 点击或选中时的背景色

      title: Text(
        privateResumeInfo.resumeLibraryDTO?.name ?? '',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: [
          Text(
            privateResumeInfo.resumeLibraryDTO?.mobile ?? '',
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(width: 8),
          user?.accessToken.tokenValue == "admin"
              ?
                // 员工名称
                Text(
                  "员工："
                  "${privateResumeInfo.userName ?? ''}",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              : Container(),
        ],
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 225, 223, 223), // 给状态加个底色
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          PrivateResumeStatus.privateResumeStatusMap[privateResumeInfo
                  .status] ??
              '',
          style: TextStyle(
            fontSize: 12,

            color:
                // const Color.fromARGB(255, 235, 11, 33),
                PrivateResumeStatus.privateResumeStatusMap[privateResumeInfo
                        .status] ==
                    '有意向'
                ? const Color.fromARGB(255, 255, 89, 0)
                : Colors.grey,
          ),
        ),
      ),

      onTap: () {
        // 点击事件
        _showUserDetailDialog(context, privateResumeInfo);
      },
    );
  }

  // 核心方法：显示详情弹窗
  void _showUserDetailDialog(BuildContext context, PrivateResumeInfo user) {
    showDialog(
      context: context,
      // barrierDismissible: true, // 默认为 true，点击弹窗外部区域即可关闭
      builder: (BuildContext context) {
        return AlertDialog(
          // 1. 标题区域
          title: Row(
            children: [
              const Icon(Icons.account_circle, color: Colors.blue, size: 30),
              const SizedBox(width: 10),
              Text(user.resumeLibraryDTO?.name ?? ''),
            ],
          ),
          content: SingleChildScrollView(
            // 防止内容过多溢出
            child: ListBody(
              children: <Widget>[
                _buildDetailRow(
                  Icons.phone,
                  "手机号",
                  user.resumeLibraryDTO?.mobile ?? '',
                ),
                _buildDetailRow(
                  Icons.person,
                  "性别",
                  user.resumeLibraryDTO?.gender == "1" ? "男" : "女",
                ),
                _buildDetailRow(
                  Icons.calendar_today,
                  "年龄",
                  user.resumeLibraryDTO?.age ?? '',
                ),
                _buildDetailRow(
                  Icons.perm_identity_outlined,
                  "身份证号",
                  user.resumeLibraryDTO?.idNo ?? '',
                ),
                _buildDetailRow(
                  Icons.location_on,
                  "工作地",
                  user.resumeLibraryDTO?.workAddr ?? '',
                ),
                _buildDetailRow(
                  Icons.location_on,
                  "户籍所在地",
                  user.resumeLibraryDTO?.domicile ?? '',
                ),
                _buildDetailRow(
                  Icons.extension,
                  "扩展信息",
                  user.resumeLibraryDTO?.extendInfo ?? '',
                ),
                const Divider(),
                Text(
                  "状态: ${PrivateResumeStatus.privateResumeStatusMap[user.status] ?? ''}",
                  style: const TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // 2. 底部按钮区域
          actions: <Widget>[
            // TextButton(
            //   child: const Text("关闭"),
            //   onPressed: () {
            //     Navigator.of(context).pop(); // 关闭弹窗
            //   },
            // ),
            // TextButton(
            //   child: const Text("编辑", style: TextStyle(color: Colors.blue)),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //     // 这里可以跳转编辑页面
            //   },
            // ),
          ],
        );
      },
    );
  }

  // 辅助方法：构建详情行
  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 10),
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
