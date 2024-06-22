import 'package:fl_chart/fl_chart.dart';

class ProfitLossPoint {
  final double underlyingPrice;
  final double profitLoss;

  ProfitLossPoint(this.underlyingPrice, this.profitLoss);

  FlSpot toFlSpot() => FlSpot(underlyingPrice, profitLoss);

  @override
  String toString() {
    return 'ProfitLossPoint(underlyingPrice: $underlyingPrice, profitLoss: $profitLoss)';
  }
}
