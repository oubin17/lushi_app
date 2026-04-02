import 'package:lushi_app/models/entities/user_entity.dart';
import 'package:lushi_app/models/entities/access_token_entity.dart';
import 'package:lushi_app/models/entities/role_entity.dart';
import 'package:lushi_app/models/entities/user_profile_entity.dart';

class UserLoginResponse extends UserEntity {
  String? token;
  UserLoginResponse({
    this.token,
    required super.userId,
    required super.userType,
    required super.userStatus,
    required super.accessToken,
    super.roles,
    super.userProfile,
  });

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) =>
      UserLoginResponse(
        token: json['token'],
        userId: json['userId'],
        userType: json['userType'],
        userStatus: json['userStatus'],
        accessToken: AccessTokenEntity.fromJson(json['accessToken']),
        roles: json['roles'] != null
            ? RoleEntity.fromJson(json['roles'])
            : null,
        userProfile: json['userProfile'] != null
            ? UserProfileEntity.fromJson(json['userProfile'])
            : null,
      );
}
