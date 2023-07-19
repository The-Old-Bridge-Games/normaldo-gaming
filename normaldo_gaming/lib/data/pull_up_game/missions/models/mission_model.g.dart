// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissionModel _$MissionModelFromJson(Map<String, dynamic> json) => MissionModel(
      type: $enumDecode(_$MissionTypeEnumMap, json['type']),
      description: json['description'] as String,
      exp: json['exp'] as int,
      isOneGame: json['isOneGame'] as bool,
      value: json['value'] as int,
      completed: json['completed'] as bool,
      item: $enumDecodeNullable(_$ItemsEnumMap, json['item']),
    );

Map<String, dynamic> _$MissionModelToJson(MissionModel instance) =>
    <String, dynamic>{
      'type': _$MissionTypeEnumMap[instance.type]!,
      'description': instance.description,
      'exp': instance.exp,
      'isOneGame': instance.isOneGame,
      'value': instance.value,
      'completed': instance.completed,
      'item': _$ItemsEnumMap[instance.item],
    };

const _$MissionTypeEnumMap = {
  MissionType.collectPizza: 'collectPizza',
  MissionType.crashItem: 'crashItem',
  MissionType.finishGame: 'finishGame',
};

const _$ItemsEnumMap = {
  Items.trashBin: 'trashBin',
  Items.pizza: 'pizza',
  Items.dollar: 'dollar',
  Items.fatPizza: 'fatPizza',
  Items.dumbbell: 'dumbbell',
  Items.moneyBag: 'moneyBag',
  Items.bomb: 'bomb',
  Items.cocktail: 'cocktail',
  Items.molotov: 'molotov',
  Items.hourglass: 'hourglass',
  Items.punch: 'punch',
  Items.bigBuddyBin: 'bigBuddyBin',
};
