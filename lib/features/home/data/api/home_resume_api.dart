import 'package:lushi_app/core/network/api_service.dart';
import 'package:lushi_app/core/utils/log_utils.dart';
import 'package:lushi_app/features/home/data/models/projectinfo_statistics_response.dart';
import 'package:lushi_app/models/response/service_response.dart';

class HomeResumeApi {
  final ApiService _apiService = ApiService.instance;

  Future<ProjectInfoStatisticsResponse> getProjectInfoStatistics() async {
    try {
      ServiceResponse response = await _apiService.get(
        '/project/info/statistic',
      );

      if (response.data == null) {
        return ProjectInfoStatisticsResponse(
          validReportCount: 0,
          addReportCount: 0,
          reviewCount: 0,
          todayReviewCount: 0,
        );
      }

      return ProjectInfoStatisticsResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e, stackTrace) {
      Log.e('🚨 [HomeResumeApi] 获取项目统计信息失败: $e, $stackTrace');
      rethrow;
    }
  }
}
