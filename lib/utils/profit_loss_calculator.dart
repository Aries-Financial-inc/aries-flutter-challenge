import '../linker.dart';

double calculateProfitLoss(
    double underlyingPrice, List<OptionContract> contracts) {
  double profitLoss = 0.0;
  for (var contract in contracts) {
    double contractPnl = 0.0;
    if (contract.type.toLowerCase() == 'call') {
      contractPnl = (underlyingPrice - contract.strikePrice > 0
              ? (underlyingPrice - contract.strikePrice)
              : 0) -
          contract.premium;
    } else if (contract.type.toLowerCase() == 'put') {
      contractPnl = (contract.strikePrice - underlyingPrice > 0
              ? (contract.strikePrice - underlyingPrice)
              : 0) -
          contract.premium;
    }
    contractPnl *= (contract.longShort.toLowerCase() == 'long' ? 1 : -1);
    profitLoss += contractPnl;
  }
  return profitLoss;
}

CustomChartData fetchChartData(
    {required List<OptionContract> contracts,
    double maxProfit = double.negativeInfinity,
    double maxLoss = double.infinity}) {
  List<ChartData> chartData = [];
  List<double> breakEvenPoints = [];
  for (double price = 50; price <= 150; price += 1) {
    final profitLoss = calculateProfitLoss(price, contracts);
    chartData.add(ChartData(price, profitLoss));

    if (profitLoss > maxProfit) {
      maxProfit = profitLoss;
    }
    if (profitLoss < maxLoss) {
      maxLoss = profitLoss;
    }
    if ((chartData.length > 1 &&
            chartData[chartData.length - 2].profitLoss * profitLoss < 0) ||
        profitLoss == 0) {
      breakEvenPoints.add(price);
    }
  }
  return CustomChartData(
      breakEvenPoints: breakEvenPoints, chartData: chartData);
}

class CustomChartData {
  List<ChartData> chartData = [];
  List<double> breakEvenPoints = [];

  CustomChartData({required this.chartData, required this.breakEvenPoints});
}
