// import 'package:normaldo_gaming/core/errors.dart';
// import 'package:normaldo_gaming/domain/skins/skins_repository.dart';

// extension SkinRarityModel on SkinRarity {
//   static fromId(int id) => switch (id) {
//         0 => SkinRarity.common,
//         1 => SkinRarity.rare,
//         2 => SkinRarity.epic,
//         3 => SkinRarity.legendary,
//         _ => throw UnexpectedError(),
//       };
// }

// final class SkinModel extends Skin {
//   SkinModel({
//     required super.id,
//     required super.name,
//     required super.path,
//     required super.rarity,
//   });

//   factory SkinModel.fromEntity(Skin skin) => SkinModel(
//         id: skin.id,
//         name: skin.name,
//         path: skin.path,
//         rarity: skin.rarity,
//       );

//   factory SkinModel.fromJson(Map<String, dynamic> json) => SkinModel(
//         id: json['id'],
//         name: json['name'],
//         path: json['path'],
//         rarity: SkinRarityModel.fromId(json['rarity'] as int),
//       );
// }
