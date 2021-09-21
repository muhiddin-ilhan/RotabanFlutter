// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DTOClient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DTOClient _$DTOClientFromJson(Map<String, dynamic> json) {
  return DTOClient(
    clientId: json['clientId'] as String?,
    companyName: json['companyName'] as String?,
    logoUrl: json['logoUrl'] as String?,
  );
}

Map<String, dynamic> _$DTOClientToJson(DTOClient instance) => <String, dynamic>{
      'clientId': instance.clientId,
      'companyName': instance.companyName,
      'logoUrl': instance.logoUrl,
    };
