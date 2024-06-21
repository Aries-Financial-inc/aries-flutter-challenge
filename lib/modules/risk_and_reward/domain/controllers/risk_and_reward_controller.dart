import 'package:flutter_challenge/modules/risk_and_reward/data/models/risk_and_reward_state_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RiskAndRewardController extends Cubit<RiskAndRewardState> {
  RiskAndRewardController() : super(RiskAndRewardState());

  void showLoader() {
    emit(state.copyWith(isLoading: true));
  }

  void hideLoader() {
    emit(state.copyWith(isLoading: false));
  }
}

