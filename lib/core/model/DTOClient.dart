import 'package:json_annotation/json_annotation.dart';
import 'package:nestle_app/core/base/model/base_model.dart';

part 'DTOClient.g.dart';

@JsonSerializable()
class DTOClient extends BaseModel<DTOClient> {
  String? clientId;
  String? companyName;
  String? logoUrl;

  DTOClient({
    this.clientId,
    this.companyName,
    this.logoUrl
  });

  factory DTOClient.fromJson(Map<String, dynamic> json) {
    return _$DTOClientFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DTOClientToJson(this);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return _$DTOClientFromJson(json);
  }
}
