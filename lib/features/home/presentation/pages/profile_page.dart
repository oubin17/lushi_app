import 'package:flutter/material.dart';
import 'package:lushi_app/core/constants/images/app_images.dart';
import 'package:lushi_app/core/storage/storage_key.dart';
import 'package:lushi_app/core/storage/storage_manager.dart';
import 'package:lushi_app/features/auth/data/models/userlogin_response.dart';
import 'package:lushi_app/features/auth/domain/auth_service.dart';
import 'package:lushi_app/features/auth/presentation/welcome.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    UserLoginResponse? user = StorageManager().getObject(
      StorageKey.userInfo,
      (json) => UserLoginResponse.fromJson(json),
    );
    return SingleChildScrollView(
      // 使用滚动视图，防止内容过多报错
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 16),
          // --- 卡片 1: 个人信息 ---
          _buildInfoCard(user!),

          const SizedBox(height: 16), // 间距
          // --- 卡片 2: 占位卡片 (待开发) ---
          _buildPlaceholderCard("其他", "暂无数据"),
          const SizedBox(height: 16),
          // --- 卡片 3: 退出登录 ---
          _buildLogoutCard("退出登录", context),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  /// 构建个人信息卡片
  Widget _buildInfoCard(UserLoginResponse user) {
    return Card(
      elevation: 2, // 阴影高度
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ), // 圆角
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // 1. 头像部分
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.grey[200],
              backgroundImage: AssetImage(
                user.isAdmin == "true"
                    ? AppImages.adminBg
                    : AppImages.employeeBg,
              ),
              // child:
              //     (user.userProfile == null ||
              //         user.userProfile!.userName == null)
              //     ? const Icon(Icons.person, size: 40, color: Colors.grey)
              //     : null,
            ),

            const SizedBox(height: 16),

            // 2. 姓名
            Text(
              user.userProfile?.userName ?? "", // 这里可以换成 user.userName
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            // 3. 职位/角色标签
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Text(
                user.isAdmin == "true" ? "管理员" : "员工",
                style: TextStyle(color: Colors.blue[700], fontSize: 12),
              ),
            ),

            const Divider(height: 30), // 分割线
            // 4. 详细信息列表 (工号、状态等)
            _buildInfoRow(Icons.badge, "工号", user.accessToken.tokenValue),
            const SizedBox(height: 12),
            _buildInfoRow(
              Icons.check_circle_outline,
              "状态",
              user.userStatus == "0" ? "正常" : "异常",
            ),
          ],
        ),
      ),
    );
  }

  /// 封装的一行信息组件 (图标 + 标题 + 内容)
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Text(label, style: TextStyle(color: Colors.grey[600])),
        const Spacer(), // 将内容推到右侧
        Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }

  /// 待定的卡片样式
  Widget _buildPlaceholderCard(String title, String subtitle) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.layers),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // 点击事件
        },
      ),
    );
  }

  Widget _buildLogoutCard(String title, BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.logout),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () async {
          // 点击事件
          await AuthService().logout();
          // 退出登录后，跳转到欢迎页
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const Welcome(),
            ),
          );
        },
      ),
    );
  }
}
