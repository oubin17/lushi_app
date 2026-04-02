class RoleEntity {
  String id;
  String roleCode;
  String roleName;
  String status;

  RoleEntity({
    required this.id,
    required this.roleCode,
    required this.roleName,
    required this.status,
  });
  factory RoleEntity.fromJson(Map<String, dynamic> json) => RoleEntity(
    id: json['id'],
    roleCode: json['roleCode'],
    roleName: json['roleName'],
    status: json['status'],
  );
}
