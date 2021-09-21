// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DTOReadQRCodeRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DTOReadQRCodeRequest _$DTOReadQRCodeRequestFromJson(Map<String, dynamic> json) {
  return DTOReadQRCodeRequest(
    SeatNum: json['SeatNum'] as String?,
    Lat: (json['Lat'] as num?)?.toDouble(),
    Lng: (json['Lng'] as num?)?.toDouble(),
    QRCodeKey: json['QRCodeKey'] as String?,
  );
}

Map<String, dynamic> _$DTOReadQRCodeRequestToJson(
        DTOReadQRCodeRequest instance) =>
    <String, dynamic>{
      'SeatNum': instance.SeatNum,
      'Lat': instance.Lat,
      'Lng': instance.Lng,
      'QRCodeKey': instance.QRCodeKey,
    };
