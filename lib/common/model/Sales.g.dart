// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Sales.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sales _$SalesFromJson(Map<String, dynamic> json) {
  return Sales(
      json['id'] as String,
      json['businessType'] as String,
      json['typeCode'] as String,
      json['custCode'] as String,
      json['deptCode'] as String,
      json['inventoryCode'] as String,
      json['quantity'] as int,
      json['bgift'] as int,
      json['rowno'] as int,);
}

Map<String, dynamic> _$SalesToJson(Sales instance) =>
    <String, dynamic>{
      'id': instance.id,
      'businessType': instance.businessType,
      'typeCode': instance.typeCode,
      'custCode': instance.custCode,
      'deptCode': instance.deptCode,
      'inventoryCode': instance.inventoryCode,
      'quantity': instance.quantity,
      'bgift': instance.bgift,
      'rowno': instance.rowno,
    };
