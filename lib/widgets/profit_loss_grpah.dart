import 'package:flutter/material.dart';
import 'package:flutter_challenge/widgets/line_chart_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'option_contract_model.dart';

class ProfitLossColumn extends StatefulWidget {
  final List<OptionContract> contracts;

  const ProfitLossColumn({
    super.key,
    required this.contracts,
  });

  @override
  State<ProfitLossColumn> createState() => _ProfitLossColumnState();
}

class _ProfitLossColumnState extends State<ProfitLossColumn> {
  double _calculateProfitLoss(double underlyingPrice) {
    double profitLoss = 0;
    for (var contract in widget.contracts) {
      double payoff = 0;
      if (contract.isCall) {
        payoff =
            (underlyingPrice - contract.strikePrice).clamp(0, double.infinity);
      } else {
        payoff =
            (contract.strikePrice - underlyingPrice).clamp(0, double.infinity);
      }
      if (!contract.isLong) {
        payoff = -payoff;
      }
      profitLoss += payoff - contract.premium;
    }
    return profitLoss;
  }

  @override
  Widget build(BuildContext context) {
    List<ChartData> data = [];
    double maxProfit = double.negativeInfinity;
    double maxLoss = double.infinity;
    List<double> breakEvenPoints = [];

    for (double price = 0.0; price <= 200.0; price += 1.0) {
      double profitLoss = _calculateProfitLoss(price);
      data.add(ChartData(price, profitLoss));

      if (profitLoss > maxProfit) {
        maxProfit = profitLoss;
      }
      if (profitLoss < maxLoss) {
        maxLoss = profitLoss;
      }
      if ((profitLoss - _calculateProfitLoss(price - 1.0)).abs() < 1e-2) {
        breakEvenPoints.add(price);
      }
    }
    return Column(
      children: [
        LineChartWidget(
          data,
          intervalType: DateTimeIntervalType.auto,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Max Profit: \$${maxProfit.toStringAsFixed(2)}'),
              Text('Max Loss: \$${maxLoss.toStringAsFixed(2)}'),
              Text(
                  'Break Even Points: ${breakEvenPoints.map((e) => e.toStringAsFixed(2)).join(', ')}'),
            ],
          ),
        ),
      ],
    );
  }
}
