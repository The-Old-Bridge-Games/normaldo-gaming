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
  Items.homeless: 'homeless',
  Items.moneyBag: 'moneyBag',
  Items.boombox: 'boombox',
  Items.cocktail: 'cocktail',
  Items.molotov: 'molotov',
  Items.hourglass: 'hourglass',
  Items.punch: 'punch',
  Items.hugeItem: 'hugeItem',
  Items.allIn: 'allIn',
  Items.angryDog: 'angryDog',
  Items.bananaPeel: 'bananaPeel',
  Items.beer: 'beer',
  Items.cannibal: 'cannibal',
  Items.casinoChip: 'casinoChip',
  Items.greenPoison: 'greenPoison',
  Items.compass: 'compass',
  Items.energizer: 'energizer',
  Items.bird: 'bird',
  Items.snake: 'snake',
  Items.policeAlarm: 'policeAlarm',
  Items.gun: 'gun',
  Items.bubbles: 'bubbles',
  Items.girl: 'girl',
  Items.goldClocks: 'goldClocks',
  Items.handcuffs: 'handcuffs',
  Items.caseyMask: 'caseyMask',
  Items.loserTicket: 'loserTicket',
  Items.magicHat: 'magicHat',
  Items.magicBox: 'magicBox',
  Items.magnet: 'magnet',
  Items.note: 'note',
  Items.note2: 'note2',
  Items.phone: 'phone',
  Items.spadesCard: 'spadesCard',
  Items.policeman: 'policeman',
  Items.security: 'security',
  Items.shipPart: 'shipPart',
  Items.cone: 'cone',
  Items.stone: 'stone',
  Items.letterBottle: 'letterBottle',
  Items.roadSign: 'roadSign',
  Items.umbrella: 'umbrella',
  Items.shredder: 'shredder',
  Items.shuriken: 'shuriken',
  Items.shredderSword: 'shredderSword',
};
