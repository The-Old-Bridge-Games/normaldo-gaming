abstract class SkinsRepository {
  List<Skin> get mySkins;
}

enum SkinRarity { common, rare, epic, legendary }

final class Skin {
  final String uniqueId;
  final String name;
  final SkinRarity rarity;
  final double speed;
  final double size;
  final double appearanceMultiplier;
  final double itemsSpeedMultiplier;
  final SkinAssets assets;

  const Skin({
    required this.uniqueId,
    required this.name,
    required this.rarity,
    required this.speed,
    required this.size,
    required this.appearanceMultiplier,
    required this.itemsSpeedMultiplier,
    required this.assets,
  });

  factory Skin.basic() => const Skin(
        uniqueId: 'basic',
        name: 'Just NORMALDO',
        rarity: SkinRarity.common,
        speed: 1,
        size: 1,
        appearanceMultiplier: 1,
        itemsSpeedMultiplier: 1,
        assets: SkinAssets(
          skinny: 'normaldo/normaldo1.png',
          slim: 'normaldo/normaldo2.png',
          fat: 'normaldo/normaldo3.png',
          superFat: 'normaldo/normaldo4.png',
          skinnyBite: 'normaldo/normaldo1_eat.png',
          slimBite: 'normaldo/normaldo2_eat.png',
          fatBite: 'normaldo/normaldo3_eat.png',
          superFatBite: 'normaldo/normaldo4_eat.png',
          dead: 'normaldo/normaldo1_dead.png',
        ),
      );
}

final class SkinAssets {
  const SkinAssets({
    required this.skinny,
    required this.slim,
    required this.fat,
    required this.superFat,
    required this.skinnyBite,
    required this.slimBite,
    required this.fatBite,
    required this.superFatBite,
    required this.dead,
    this.url = false,
    this.sfx,
  });

  final bool url;
  final String skinny;
  final String slim;
  final String fat;
  final String superFat;
  final String skinnyBite;
  final String slimBite;
  final String fatBite;
  final String superFatBite;
  final String dead;

  final Map<String, String>? sfx;
}
