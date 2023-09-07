import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ads_state.dart';
part 'ads_cubit.freezed.dart';

class AdsCubit extends Cubit<AdsState> {
  AdsCubit() : super(const AdsState.initial());

  void setState(AdsState newState) {
    emit(newState);
  }
}
