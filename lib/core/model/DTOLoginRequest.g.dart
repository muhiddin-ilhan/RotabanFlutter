// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DTOLoginRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DTOLoginRequest _$DTOLoginRequestFromJson(Map<String, dynamic> json) {
  return DTOLoginRequest(
    UserName: json['UserName'] as String?,
    Password: json['Password'] as String?,
    RememberMe: json['RememberMe'] as bool?,
  );
}

Map<String, dynamic> _$DTOLoginRequestToJson(DTOLoginRequest instance) =>
    <String, dynamic>{
      'UserName': instance.UserName,
      'Password': instance.Password,
      'RememberMe': instance.RememberMe,
    };
