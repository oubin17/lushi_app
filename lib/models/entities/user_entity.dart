import 'package:json_annotation/json_annotation.dart';
import 'package:lushi_app/models/entities/access_token_entity.dart';
import 'package:lushi_app/models/entities/role_entity.dart';
import 'package:lushi_app/models/entities/user_profile_entity.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  String userId;
  String userType;
  String userStatus;
  AccessTokenEntity accessToken;
  List<RoleEntity>? roles;
  UserProfileEntity? userProfile;

  UserEntity({
    required this.userId,
    required this.userType,
    required this.userStatus,
    required this.accessToken,
    this.roles,
    this.userProfile,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}
