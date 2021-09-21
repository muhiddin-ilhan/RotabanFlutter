import 'package:json_annotation/json_annotation.dart';
import 'package:nestle_app/core/base/model/base_model.dart';
import 'package:nestle_app/core/model/DTOClient.dart';

part 'DTOUserInfo.g.dart';

@JsonSerializable()
class DTOUserInfo extends BaseModel<DTOUserInfo> {
  String? username;
  String? name;
  String? surname;
  bool? useService;
  DTOClient? client;

  DTOUserInfo({
    this.username,
    this.name,
    this.surname,
    this.useService,
    this.client,
  });

  factory DTOUserInfo.fromJson(Map<String, dynamic> json) {
    return _$DTOUserInfoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DTOUserInfoToJson(this);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return _$DTOUserInfoFromJson(json);
  }
}
