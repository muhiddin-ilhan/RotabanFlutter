// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DTOReadQRCodeResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DTOReadQRCodeResponse _$DTOReadQRCodeResponseFromJson(
    Map<String, dynamic> json) {
  return DTOReadQRCodeResponse(
    code: json['code'] as int?,
    message: json['message'] as String?,
    data: json['data'],
  );
}

Map<String, dynamic> _$DTOReadQRCodeResponseToJson(
        DTOReadQRCodeResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
