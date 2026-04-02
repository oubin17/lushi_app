class UserProfileEntity {
  String? userName;
  String? gender;
  String? birthDay;

  UserProfileEntity({this.userName, this.gender, this.birthDay});
  factory UserProfileEntity.fromJson(Map<String, dynamic> json) =>
      UserProfileEntity(
        userName: json['userName'],
        gender: json['gender'],
        birthDay: json['birthDay'],
      );
}
