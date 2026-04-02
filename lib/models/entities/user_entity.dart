import 'package:lushi_app/models/entities/access_token_entity.dart';
import 'package:lushi_app/models/entities/role_entity.dart';
import 'package:lushi_app/models/entities/user_profile_entity.dart';

class UserEntity {
  String userId;
  String userType;
  String userStatus;
  AccessTokenEntity accessToken;
  RoleEntity? roles;
  UserProfileEntity? userProfile;

  UserEntity({
    required this.userId,
    required this.userType,
    required this.userStatus,
    required this.accessToken,
    this.roles,
    this.userProfile,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
    userId: json['userId'],
    userType: json['userType'],
    userStatus: json['userStatus'],
    accessToken: AccessTokenEntity.fromJson(json['accessToken']),
    roles: json['roles'] != null ? RoleEntity.fromJson(json['roles']) : null,
    userProfile: json['userProfile'] != null
        ? UserProfileEntity.fromJson(json['userProfile'])
        : null,
  );
}
