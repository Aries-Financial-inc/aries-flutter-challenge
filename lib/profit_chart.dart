import 'package:flutter/material.dart';
import 'package:flutter_challenge/utils/calculator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OptionProfitChart extends StatelessWidget {

  const OptionProfitChart({
    super.key, 
    required this.option
  });

  final Map<String, dynamic> option;

  Widget _infoItem(String property, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _infoProperty(property), 
        _infoValue(value)
      ]
    );
  }

  Widget _infoProperty(String property) {
    return Text(property, style: const TextStyle(fontWeight: FontWeight.bold),);
  }

  Widget _infoValue(String value) {
    return Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.lightBlueAccent));
  }


  Widget _buildInfo() {
    
    var infos = [
      _infoItem("Option Strategy:", "${option['long_short']} ${option['type']}"),
      Row(
        children: [
          _infoProperty("Strike: "),  _infoValue("${option['strike_price']} \t\t"), 
          _infoProperty("Bid: "),     _infoValue("${option['bid']} \t\t"), 
          _infoProperty("Ask: "),     _infoValue("${option['ask']} \t\t"),
        ]
      ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromARGB(255, 193, 234, 252), 
      ),
      child:
        Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: infos
      )
    );
  }

  Widget _buildFeature() {
    Feature feature = calculateFeature(option); 

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _infoItem("Max Profit:", "${feature.maxProfit}"),
      _infoItem("Max Loss:",   feature.maxLoss.toStringAsFixed(2)),
      _infoItem("Breakeven Price:",  feature.breakeven.toString()),
    ],); 

  }

  Widget _buildProfitChart() {
    List<int> prices = List.generate(201, (int index) => index);
    final List<ChartData> chartData = prices.map((price) => ChartData(price, calculateProfits(option, price.toDouble()))).toList(); 
   

    return SfCartesianChart(
        primaryXAxis: const NumericAxis(), 
        primaryYAxis: const NumericAxis(),
        series: <CartesianSeries<ChartData, int>>[
        LineSeries<ChartData, int>(
            dataSource: chartData,
            markerSettings: const MarkerSettings(isVisible: false),
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y),
        ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.all(30),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 30,
            offset: const Offset(4, 4),
          ),
        ],
        color: Colors.white.withOpacity(0.8),
      ),
      child: Column(children: [
          _buildInfo(),
          _buildProfitChart(),
          _buildFeature(),
        ])
      );
    
  }
}


class ChartData{
    ChartData(this.x, this.y);
    final int x;
    final double y;
}