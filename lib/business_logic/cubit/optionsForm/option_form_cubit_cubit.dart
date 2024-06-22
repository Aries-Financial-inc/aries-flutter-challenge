import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge/constants/enums.dart';

part 'option_form_cubit_state.dart';

class OptionFormCubit extends Cubit<OptionFormState> {
  OptionFormCubit()
      : super(OptionFormState(
          strikePrice: 0.0,
          type: OptionTypes.call,
          bid: 0.0,
          ask: 0.0,
          longShort: LongShort.long,
          expirationDate: DateTime.now(),
        ));

  void updateStrikePrice(double value) {
    emit(state.copyWith(strikePrice: value));
  }

  void updateType(OptionTypes value) {
    emit(state.copyWith(type: value));
  }

  void updateBid(double value) {
    emit(state.copyWith(bid: value));
  }

  void updateAsk(double value) {
    emit(state.copyWith(ask: value));
  }

  void updateLongShort(LongShort value) {
    emit(state.copyWith(longShort: value));
  }

  void updateExpirationDate(DateTime value) {
    emit(state.copyWith(expirationDate: value));
  }
}

class VisibilityCubit extends Cubit<bool> {
  VisibilityCubit() : super(true);

  // Toggle the visibility state
  void toggleVisibility() => emit(!state);
}
