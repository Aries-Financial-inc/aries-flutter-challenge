import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge/models/option.model.dart';

part 'risk_reward_graph_state.dart';

class RiskRewardGraphCubit extends Cubit<RiskRewardGraphState> {
  RiskRewardGraphCubit() : super(RiskRewardGraphState([]));

  void addDataPoint(OptionData dataPoint) {
    final updatedDataPoints = List<OptionData>.from(state.dataPoints)
      ..add(dataPoint);
    emit(RiskRewardGraphState(updatedDataPoints));
  }

  void clearAllData() {
    emit(RiskRewardGraphState([])); // Clear all data by resetting to empty list
  }
}
