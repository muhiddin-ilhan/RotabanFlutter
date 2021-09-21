import 'package:json_annotation/json_annotation.dart';
import 'package:nestle_app/core/base/model/base_model.dart';

part 'DTOLoginResponse.g.dart';

@JsonSerializable()
class DTOLoginResponse extends BaseModel<DTOLoginResponse> {
  // ignore: non_constant_identifier_names
  String? access_token;
  // ignore: non_constant_identifier_names
  String? refresh_token;

  DTOLoginResponse({
    // ignore: non_constant_identifier_names
    this.access_token,
    // ignore: non_constant_identifier_names
    this.refresh_token
  });

  factory DTOLoginResponse.fromJson(Map<String, dynamic> json) {
    return _$DTOLoginResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DTOLoginResponseToJson(this);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return _$DTOLoginResponseFromJson(json);
  }
}
