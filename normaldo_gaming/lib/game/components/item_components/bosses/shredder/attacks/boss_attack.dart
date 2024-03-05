import 'package:normaldo_gaming/game/components/item_components/bosses/boss_component.dart';
import 'package:normaldo_gaming/game/components/grid.dart';

abstract base class BossAttack {
  bool get inProgress;
  bool get completed;

  void start(Boss boss, Grid grid);
}
