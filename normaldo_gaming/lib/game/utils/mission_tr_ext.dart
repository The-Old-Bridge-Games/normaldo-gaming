import 'package:easy_localization/easy_localization.dart';
import 'package:normaldo_gaming/domain/pull_up_game/mission.dart';

extension MissionTr on Mission {
  String trDescription() {
    return switch (this) {
      CollectPizzaInOneGameMission() =>
        description.plural(value, args: [value.toString()]),
      FinishGameAtLevelMission() => description.tr(),
      CrashItemInOneGameMission() => description.plural(value, args: [
          value.toString(),
          (this as CrashItemInOneGameMission).item.name.plural(value)
        ])
    };
  }
}
