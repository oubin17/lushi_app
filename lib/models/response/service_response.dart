import 'package:lushi_app/models/response/base_response.dart';

class ServiceResponse<T> extends BaseResponse {
  T? data;
  ServiceResponse({required super.success, required this.data});
  ServiceResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    data = json['data'];
  }
}
