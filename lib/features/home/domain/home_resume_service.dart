import 'package:lushi_app/features/home/data/api/home_resume_api.dart';
import 'package:lushi_app/features/home/data/models/private_resume.dart';
import 'package:lushi_app/features/home/data/models/project_info.dart';
import 'package:lushi_app/features/home/data/models/projectinfo_statistics_response.dart';

class HomeResumeService {
  final HomeResumeApi homeResumeApi = HomeResumeApi();

  /// 获取首页项目统计信息
  Future<ProjectInfoStatisticsResponse> getProjectInfoStatistics() async {
    return await homeResumeApi.getProjectInfoStatistics();
  }

  /// 获取首页项目列表
  Future<List<ProjectInfo>> getProjectInfo() async {
    return await homeResumeApi.getProjectInfo();
  }

  /// 获取隐私简历列表
  Future<List<PrivateResumeInfo>> getPrivateResumeInfo() async {
    return await homeResumeApi.getPrivateResumeInfo();
  }
}
