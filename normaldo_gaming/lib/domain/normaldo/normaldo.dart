import 'package:normaldo_gaming/domain/skins/skins_repository.dart';

final class Normaldo {
  Normaldo({
    Skin? skin,
    NormaldoFatState? fatState,
    NormaldoHitState? hitState,
  })  : _skin = skin ?? Skin.defaultOne(),
        _fatState = NormaldoFatState.skinny,
        _hitState = NormaldoHitState.idle;

  Skin _skin;
  NormaldoFatState _fatState;
  NormaldoHitState _hitState;

  bool get isImmortal => _hitState == NormaldoHitState.hit;
}

enum NormaldoHitState {
  idle,
  hit,
}

enum NormaldoFatState {
  skinny,
  slim,
  fat,
  uberFat,

  // eating states
  skinnyEat,
  slimEat,
  fatEat,
  uberFatEat,

  // dead states
  skinnyDead,
  slimDead,
  fatDead,
  uberFatDead;

  int get pizzaToFat {
    return switch (this) {
      skinny || skinnyEat => 30,
      slim || slimEat => 40,
      fat || fatEat => 50,
      uberFat || uberFatEat => 60,
      _ => 1
    };
  }

  NormaldoFatState get dead {
    switch (this) {
      case NormaldoFatState.skinny:
      case NormaldoFatState.skinnyEat:
        return NormaldoFatState.skinnyDead;
      case NormaldoFatState.slim:
      case NormaldoFatState.slimEat:
        return NormaldoFatState.slimDead;
      case NormaldoFatState.fat:
      case NormaldoFatState.fatEat:
        return NormaldoFatState.fatDead;
      case NormaldoFatState.uberFat:
      case NormaldoFatState.uberFatEat:
        return NormaldoFatState.uberFatDead;
      default:
        return this;
    }
  }

  static List<NormaldoFatState> get onlyIdle => [
        skinny,
        slim,
        fat,
        uberFat,
      ];

  static List<NormaldoFatState> get onlyEating => [
        skinnyEat,
        slimEat,
        fatEat,
        uberFatEat,
      ];
}
