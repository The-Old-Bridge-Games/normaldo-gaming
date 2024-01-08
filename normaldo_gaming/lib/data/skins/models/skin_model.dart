import 'package:normaldo_gaming/domain/skins/skins_repository.dart';

abstract class SkinDto {
  const SkinDto();

  static Skin fromJson(Map<String, dynamic> json) => Skin(
        uniqueId: json['uniqueId'],
        name: json['name'],
        rarity: SkinRarity.values[json['rarity']],
        speed: json['speed'],
        size: json['size'],
        appearanceMultiplier: json['appearanceMultiplier'],
        itemsSpeedMultiplier: json['itemsSpeedMultiplier'],
        assets: SkinAssets(
          skinny: json['assets']['skinny'],
          slim: json['assets']['slim'],
          fat: json['assets']['fat'],
          superFat: json['assets']['superFat'],
          skinnyBite: json['assets']['skinnyBite'],
          slimBite: json['assets']['slimBite'],
          fatBite: json['assets']['fatBite'],
          superFatBite: json['assets']['superFatBite'],
          dead: json['assets']['dead'],
          url: json['assets']['url'],
          sfx: json['assets']['sfx'],
        ),
      );

  static Map<String, dynamic> toJson(Skin skin) => {
        'uniqueId': skin.uniqueId,
        'name': skin.name,
        'rarity': skin.rarity.index,
        'speed': skin.speed,
        'size': skin.size,
        'appearanceMultiplier': skin.appearanceMultiplier,
        'itemsSpeedMultiplier': skin.itemsSpeedMultiplier,
        'assets': {
          'skinny': skin.assets.skinny,
          'slim': skin.assets.slim,
          'fat': skin.assets.fat,
          'superFat': skin.assets.superFat,
          'skinnyBite': skin.assets.skinnyBite,
          'slimBite': skin.assets.slimBite,
          'fatBite': skin.assets.fatBite,
          'superFatBite': skin.assets.superFatBite,
          'dead': skin.assets.dead,
          'url': skin.assets.url,
          'sfx': skin.assets.sfx,
        }
      };
}
