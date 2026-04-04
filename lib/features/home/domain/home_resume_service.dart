import 'package:lushi_app/features/home/data/api/home_resume_api.dart';
import 'package:lushi_app/features/home/data/models/projectinfo_statistics_response.dart';

class HomeResumeService {
  final HomeResumeApi homeResumeApi = HomeResumeApi();

  /// 获取首页项目统计信息
  Future<ProjectInfoStatisticsResponse> getProjectInfoStatistics() async {
    return await homeResumeApi.getProjectInfoStatistics();
  }
}
