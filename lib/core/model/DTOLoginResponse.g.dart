// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DTOLoginResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DTOLoginResponse _$DTOLoginResponseFromJson(Map<String, dynamic> json) {
  return DTOLoginResponse(
    access_token: json['access_token'] as String?,
    refresh_token: json['refresh_token'] as String?,
  );
}

Map<String, dynamic> _$DTOLoginResponseToJson(DTOLoginResponse instance) =>
    <String, dynamic>{
      'access_token': instance.access_token,
      'refresh_token': instance.refresh_token,
    };
