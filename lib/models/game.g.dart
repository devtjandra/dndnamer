// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) {
  return Game(
    uuid: json['uuid'] as String,
    accountUid: json['accountUid'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'accountUid': instance.accountUid,
      'title': instance.title,
      'description': instance.description,
    };
