// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person(
    uuid: json['uuid'] as String,
    gameUuid: json['gameUuid'] as String,
    name: json['name'] as String,
    importance: json['importance'] as int,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'gameUuid': instance.gameUuid,
      'name': instance.name,
      'importance': instance.importance,
      'description': instance.description,
    };
