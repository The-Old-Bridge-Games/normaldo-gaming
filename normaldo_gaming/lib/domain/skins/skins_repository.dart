import 'package:normaldo_gaming/domain/pull_up_game/items.dart';

abstract class SkinsRepository {
  List<Skin> get mySkins;
}

enum SkinRarity { classic, common, rare, epic, legendary }

final class Skin {
  final String uniqueId;
  final String name;
  final SkinRarity rarity;
  final SkinAssets assets;
  final List<Items> resistanceToItems;

  const Skin({
    required this.uniqueId,
    required this.name,
    required this.rarity,
    required this.assets,
    required this.resistanceToItems,
  });

  factory Skin.basic() => const Skin(
        uniqueId: 'basic',
        name: 'Normaldo',
        rarity: SkinRarity.classic,
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
          mask: '',
        ),
        resistanceToItems: [],
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
    required this.mask,
    this.url = false,
    this.sfx = const {},
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
  final String mask;

  final Map<String, List<String>> sfx;
}
