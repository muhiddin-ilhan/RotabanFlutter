// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DTOUserInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DTOUserInfo _$DTOUserInfoFromJson(Map<String, dynamic> json) {
  return DTOUserInfo(
    username: json['username'] as String?,
    name: json['name'] as String?,
    surname: json['surname'] as String?,
    useService: json['useService'] as bool?,
    client: json['client'] == null
        ? null
        : DTOClient.fromJson(json['client'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DTOUserInfoToJson(DTOUserInfo instance) =>
    <String, dynamic>{
      'username': instance.username,
      'name': instance.name,
      'surname': instance.surname,
      'useService': instance.useService,
      'client': instance.client,
    };
