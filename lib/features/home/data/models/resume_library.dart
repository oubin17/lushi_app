import 'package:json_annotation/json_annotation.dart';

part 'resume_library.g.dart';

@JsonSerializable()
class ResumeLibraryInfo {
  String? name;
  String? mobile;
  String? age;

  String? gender;

  String? userName;

  ResumeLibraryInfo({
    this.name,
    this.mobile,
    this.age,
    this.gender,
    this.userName,
  });

  factory ResumeLibraryInfo.fromJson(Map<String, dynamic> json) =>
      _$ResumeLibraryInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ResumeLibraryInfoToJson(this);
}
