import 'package:json_annotation/json_annotation.dart';
import 'package:nestle_app/core/base/model/base_model.dart';

part 'DTOReadQRCodeRequest.g.dart';

@JsonSerializable()
class DTOReadQRCodeRequest extends BaseModel<DTOReadQRCodeRequest> {
  // ignore: non_constant_identifier_names
  String? SeatNum;
  // ignore: non_constant_identifier_names
  double? Lat;
  // ignore: non_constant_identifier_names
  double? Lng;
  // ignore: non_constant_identifier_names
  String? QRCodeKey;

  DTOReadQRCodeRequest({
    // ignore: non_constant_identifier_names
    this.SeatNum,
    // ignore: non_constant_identifier_names
    this.Lat,
    // ignore: non_constant_identifier_names
    this.Lng,
    // ignore: non_constant_identifier_names
    this.QRCodeKey,
  });

  factory DTOReadQRCodeRequest.fromJson(Map<String, dynamic> json) {
    return _$DTOReadQRCodeRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DTOReadQRCodeRequestToJson(this);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return _$DTOReadQRCodeRequestFromJson(json);
  }
}
