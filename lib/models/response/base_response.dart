class BaseResponse {
  bool success;
  String? errorType;
  String? errorCode;
  String? errorContext;
  BaseResponse({required this.success});
  BaseResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'],
      errorType = json['errorType'],
      errorCode = json['errorCode'],
      errorContext = json['errorContext'];
}
