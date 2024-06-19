import 'package:flutter/material.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

class RiskRewardChart extends StatelessWidget {
  const RiskRewardChart({super.key});

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      LinearSales(0, 5),
      LinearSales(1, 25),
      LinearSales(2, 100),
      LinearSales(3, 75),
    ];

    return [
      charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final seriesList = _createSampleData();
    return charts.LineChart(seriesList, animate: true);
  }
}
