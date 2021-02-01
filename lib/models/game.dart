import 'package:dndnamer/models/person.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'game.g.dart';

@JsonSerializable(explicitToJson: false)
class Game {
  final String uuid;
  final String accountUid;
  final String title;
  final String description;

  Game(
      {@required this.uuid,
      @required this.accountUid,
      @required this.title,
      this.description});

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  Map<String, dynamic> toJson() => _$GameToJson(this);
}
