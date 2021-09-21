import 'package:json_annotation/json_annotation.dart';
import 'package:nestle_app/core/base/model/base_model.dart';

part 'DTOQrData.g.dart';

@JsonSerializable()
class DTOQrData extends BaseModel<DTOQrData> {
  // ignore: non_constant_identifier_names
  String? PlateNo;
  // ignore: non_constant_identifier_names
  String? SeatNum;
  // ignore: non_constant_identifier_names
  String? Key;

  DTOQrData({
    // ignore: non_constant_identifier_names
    this.PlateNo,
    // ignore: non_constant_identifier_names
    this.SeatNum,
    // ignore: non_constant_identifier_names
    this.Key,
  });

  factory DTOQrData.fromJson(Map<String, dynamic> json) {
    return _$DTOQrDataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DTOQrDataToJson(this);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return _$DTOQrDataFromJson(json);
  }
}
