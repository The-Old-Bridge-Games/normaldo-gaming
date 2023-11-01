import 'package:normaldo_gaming/game/components/buffs&debuffs/bosses/shredder/shredder.dart';
import 'package:normaldo_gaming/game/components/grid.dart';

abstract base class ShredderAttack {
  bool get completed;

  void start(Shredder shredder, Grid grid);
}
