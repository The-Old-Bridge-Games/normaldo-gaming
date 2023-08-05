import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:normaldo_gaming/core/roller/roller.dart';
import 'package:normaldo_gaming/domain/roller/rolls.dart';

part 'slot_machine_state.dart';
part 'slot_machine_cubit.freezed.dart';

class SlotMachineCubit extends Cubit<SlotMachineState> {
  SlotMachineCubit() : super(SlotMachineState.initial());

  void roll() {
    if (state.bid < 5) return;
    final step = state.bid ~/ 5;
    final roller = Roller<Rolls>(List.generate(Rolls.values.length, (index) {
      final roll = Rolls.values[index];
      return (roll, roll.weight(step));
    }));
    final roll = roller.roll();
    emit(state.copyWith(winRoll: roll, spinning: true));
  }

  void changeBid({required int bid}) {
    assert(bid >= 5);
    assert(bid <= 100);
    assert(bid % 5 == 0);

    emit(state.copyWith(bid: bid));
  }

  void stopSpin() {
    emit(state.copyWith(winRoll: null, spinning: false));
  }
}
