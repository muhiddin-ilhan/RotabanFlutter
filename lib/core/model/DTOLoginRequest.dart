import 'package:json_annotation/json_annotation.dart';
import 'package:nestle_app/core/base/model/base_model.dart';

part 'DTOLoginRequest.g.dart';

@JsonSerializable()
class DTOLoginRequest extends BaseModel<DTOLoginRequest> {
  // ignore: non_constant_identifier_names
  String? UserName;
  // ignore: non_constant_identifier_names
  String? Password;
  // ignore: non_constant_identifier_names
  bool? RememberMe;

  DTOLoginRequest({
    // ignore: non_constant_identifier_names
    this.UserName,
    // ignore: non_constant_identifier_names
    this.Password,
    // ignore: non_constant_identifier_names
    this.RememberMe,
  });

  factory DTOLoginRequest.fromJson(Map<String, dynamic> json) {
    return _$DTOLoginRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DTOLoginRequestToJson(this);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return _$DTOLoginRequestFromJson(json);
  }
}
