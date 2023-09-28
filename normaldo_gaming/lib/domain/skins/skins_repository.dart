enum SkinRarity {
  common,
  rare,
  epic,
  legendary,
}

abstract interface class SkinsRepository {
  Future<List<Skin>> getAll();
}

base class Skin {
  final String uniqueId;
  final Map<String, String> assets;
  final String name;
  final SkinRarity rarity;
  final int speed; // 1
  final int size; // 1
  final double appearanceMultiplier; // 1
  final double itemsSpeedMultiplier; // 1

  Skin({
    required this.uniqueId,
    required this.assets,
    required this.appearanceMultiplier,
    required this.itemsSpeedMultiplier,
    required this.name,
    required this.rarity,
    required this.speed,
    required this.size,
  });

  factory Skin.defaultOne() => Skin(
        uniqueId: 'default',
        name: 'N0rmaldo',
        assets: {},
        rarity: SkinRarity.common,
        appearanceMultiplier: 1,
        itemsSpeedMultiplier: 1,
        speed: 1,
        size: 1,
      );
}
