import 'package:flame/components.dart';
import 'package:normaldo_gaming/domain/normaldo/normaldo.dart';

Future<Map<NormaldoFatState, Sprite>> normaldoSprites() async {
  final skinnySprite = await Sprite.load('normaldo/normaldo1.png');
  final slimSprite = await Sprite.load('normaldo/normaldo2.png');
  final fatSprite = await Sprite.load('normaldo/normaldo3.png');
  final uberFatSprite = await Sprite.load('normaldo/normaldo4.png');

  final skinnyEatSprite = await Sprite.load('normaldo/normaldo1_eat.png');
  final slimEatSprite = await Sprite.load('normaldo/normaldo2_eat.png');
  final fatEatSprite = await Sprite.load('normaldo/normaldo3_eat.png');
  final uberFatEatSprite = await Sprite.load('normaldo/normaldo4_eat.png');

  final skinnyDeadSprite = await Sprite.load('normaldo/normaldo1_dead.png');
  final slimDeadSprite = await Sprite.load('normaldo/normaldo2_dead.png');
  final fatDeadSprite = await Sprite.load('normaldo/normaldo3_dead.png');
  final uberFatDeadSprite = await Sprite.load('normaldo/normaldo4_dead.png');
  return {
    NormaldoFatState.skinny: skinnySprite,
    NormaldoFatState.slim: slimSprite,
    NormaldoFatState.fat: fatSprite,
    NormaldoFatState.uberFat: uberFatSprite,

    // eating
    NormaldoFatState.skinnyEat: skinnyEatSprite,
    NormaldoFatState.slimEat: slimEatSprite,
    NormaldoFatState.fatEat: fatEatSprite,
    NormaldoFatState.uberFatEat: uberFatEatSprite,

    // dead
    NormaldoFatState.skinnyDead: skinnyDeadSprite,
    NormaldoFatState.slimDead: slimDeadSprite,
    NormaldoFatState.fatDead: fatDeadSprite,
    NormaldoFatState.uberFatDead: uberFatDeadSprite,
  };
}
