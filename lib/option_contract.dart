class OptionContract {
  final double strikePrice;
  final double premium;
  final bool isCall;
  final bool isLong;

  OptionContract({
    required this.strikePrice,
    required this.premium,
    required this.isCall,
    required this.isLong,
  });

  static List<OptionContract> fromJson(List<Map<String, dynamic>> json) {
    return json.map((data) {
      return OptionContract(
        strikePrice: (data['strike_price'] as num).toDouble(),
        premium: (data['bid'] + data['ask']) / 2,
        isCall: data['type'] == 'Call',
        isLong: data['long_short'] == 'long',
      );
    }).toList();
  }
}

extension Strategy on List<OptionContract> {
  double calculateProfitLoss(double price) {
    double profitLoss = 0;
    for (final contract in this) {
      double value = 0;
      if (contract.isCall) {
        value = (price - contract.strikePrice).clamp(0, double.infinity);
      } else {
        value = (contract.strikePrice - price).clamp(0, double.infinity);
      }
      profitLoss += (value - contract.premium) * (contract.isLong ? 1 : -1);
    }
    return profitLoss;
  }

  List<double> getBreakEvenPoints() {
    final List<double> breakEvenPoints = [];
    for (final contract in this) {
      double breakEven;
      if (contract.isCall) {
        breakEven = contract.strikePrice + contract.premium;
      } else {
        breakEven = contract.strikePrice - contract.premium;
      }
      breakEvenPoints.add(breakEven);
    }
    return breakEvenPoints;
  }

  double getMaxProfit() {
    double maxProfit = double.infinity;
    for (final contract in this) {
      if (contract.isCall) {
        maxProfit = (contract.strikePrice + contract.premium);
      } else {
        maxProfit = (contract.strikePrice - contract.premium);
      }
    }
    return maxProfit - fold(0, (sum, contract) => sum + contract.premium);
  }

  double getMaxLoss() {
    return fold(0, (pValue, contract) => pValue + contract.premium);
  }

  List<double> getChartData() {
    return List.generate(
      200,
      (i) => calculateProfitLoss(i.toDouble()),
    );
  }
}
