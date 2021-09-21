import 'package:json_annotation/json_annotation.dart';
import 'package:nestle_app/core/base/model/base_model.dart';

part 'DTOReadQRCodeResponse.g.dart';

@JsonSerializable()
class DTOReadQRCodeResponse extends BaseModel<DTOReadQRCodeResponse> {
  // ignore: non_constant_identifier_names
  int? code;
  String? message;
  dynamic data;

  DTOReadQRCodeResponse({
    // ignore: non_constant_identifier_names
    this.code,
    // ignore: non_constant_identifier_names
    this.message,
    // ignore: non_constant_identifier_names
    this.data,
  });

  factory DTOReadQRCodeResponse.fromJson(Map<String, dynamic> json) {
    return _$DTOReadQRCodeResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DTOReadQRCodeResponseToJson(this);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return _$DTOReadQRCodeResponseFromJson(json);
  }
}
