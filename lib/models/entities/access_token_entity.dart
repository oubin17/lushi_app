class AccessTokenEntity {
  String tokenValue;
  String tokenType;

  AccessTokenEntity({required this.tokenValue, required this.tokenType});
  factory AccessTokenEntity.fromJson(Map<String, dynamic> json) =>
      AccessTokenEntity(
        tokenValue: json['tokenValue'],
        tokenType: json['tokenType'],
      );
}
