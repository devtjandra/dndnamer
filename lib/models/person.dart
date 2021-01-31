import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable(explicitToJson: false)
class Person {
  final String uuid;
  final String gameUuid;
  final String name;
  final int importance;
  final String description;

  Person({
    @required this.uuid,
    @required this.gameUuid,
    @required this.name,
    @required this.importance,
    this.description
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
