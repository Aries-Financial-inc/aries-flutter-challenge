import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_challenge/options_data.dart';
import 'package:flutter_challenge/enum.dart';
import 'package:flutter_challenge/options_strategy.dart';
import 'package:flutter_challenge/widget_extensions.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OptionsGraph extends StatefulHookConsumerWidget {
  const OptionsGraph({super.key});

  @override
  _OptionsGraphState createState() => _OptionsGraphState();
}

class _OptionsGraphState extends ConsumerState<OptionsGraph> {
  @override
  void initState() {
    // mapData();
    super.initState();
  }

  /// below function is used to map the static data and add to provider.
  /// If your looking to add the data directly to the provider, please enable in initState()
  ///
  void mapData() {
    data.forEach((e) async {
      OptionsContract data = OptionsContract(
          type: optionTypes.call.name == (e["type"] as String).toLowerCase()
              ? optionTypes.call
              : optionTypes.put,
          strikePrice: double.parse(e["strike_price"].toString()),
          avgOfBidAndAsk: (double.parse(e["bid"].toString()) +
                  double.parse(e["ask"].toString())) /
              2,
          avg: double.parse(e["ask"].toString()),
          bid: double.parse(e["bid"].toString()));
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        await ref.read(optionsContractProvider.notifier).addItem(data);
      });
    });
  }

  Widget MaxMinBreakPoint({
    required String strikePrice,
    required String max,
    required String min,
    required String breakEven,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text("***********"),
        Text("strikePrice == $strikePrice"),
        Text("Maximum Profit == $max"),
        Text("Maximum Loss == $min"),
        Text("Break Even point Profit == $breakEven"),
      ],
    ).paddingAll(20);
  }

  @override
  Widget build(BuildContext context) {
    final showGraph = useState(false);
    final type = useTextEditingController();
    final strikePrice = useTextEditingController();
    final bid = useTextEditingController();
    final ask = useTextEditingController();
    final optionsContractP = ref.watch(optionsContractProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  controller: type,
                  decoration: const InputDecoration(
                    label: Text("Enter type"),
                  ),
                ),
                TextFormField(
                  controller: strikePrice,
                  decoration: const InputDecoration(
                    label: Text("Enter strikePrice"),
                  ),
                ),
                TextFormField(
                  controller: bid,
                  decoration: const InputDecoration(
                    label: Text("Enter Bid price"),
                  ),
                ),
                TextFormField(
                  controller: ask,
                  decoration: const InputDecoration(
                    label: Text("Enter ask price"),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await ref.read(optionsContractProvider.notifier).addItem(
                    OptionsContract(
                      type: type.text.toLowerCase() == "call"
                          ? optionTypes.call
                          : optionTypes.put,
                      strikePrice: double.parse(strikePrice.text),
                      avgOfBidAndAsk:
                          (double.parse(bid.text) + double.parse(ask.text)) / 2,
                      avg: double.parse(ask.text),
                      bid: double.parse(bid.text),
                    ),
                  );

              type.clear();
              bid.clear();
              ask.clear();
              strikePrice.clear();
            },
            child: const Text("Add Data"),
          ),
          const Text(
                  "Once data is finalized, click on show Graph to generate and plot")
              .paddingAll(20),
          ElevatedButton(
              onPressed: () {
                showGraph.value = true;
                _getSpots(ref);
              },
              child: const Text("Show Graph On")),
          Container(
            height: 500,
            margin: const EdgeInsets.only(bottom: 20),
            child: LineChart(
              LineChartData(
                minX: 95,
                maxX: 110,
                minY: -20,
                maxY: 5,
                titlesData: const FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true),
                    axisNameWidget: Text("underlying at the time of expiry"),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true),
                    axisNameWidget: Text("profit/loss at that price"),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: ref.watch(spots),
                    isCurved: true,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: true),
                    color: Colors.grey[500],
                    curveSmoothness: 0.1,
                    isStrokeJoinRound: true,
                    isStepLineChart: true,
                    aboveBarData: BarAreaData(
                      applyCutOffY: true,
                      show: true,
                      color: Colors.green.withOpacity(0.3),
                    ),
                    belowBarData: BarAreaData(
                      applyCutOffY: false,
                      show: true,
                      color: Colors.red.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: optionsContractP.length,
              itemBuilder: (context, index) {
                return MaxMinBreakPoint(
                  strikePrice: ref
                      .watch(optionsContractProvider)[index]
                      .strikePrice
                      .toString(),
                  max: optionsContractP[index].type == optionTypes.call
                      ? "infinity"
                      : ref
                          .watch(optionsContractProvider)[index]
                          .bid
                          .toString(),
                  min: optionsContractP[index].type == optionTypes.put
                      ? "infinity"
                      : ref
                          .watch(optionsContractProvider)[index]
                          .bid
                          .toString(),
                  breakEven: optionsContractP[index].type == optionTypes.call
                      ? (optionsContractP[index].strikePrice +
                              optionsContractP[index].bid)
                          .toString()
                      : (optionsContractP[index].strikePrice -
                              optionsContractP[index].bid)
                          .toString(),
                );
              }),
        ],
      ),
    );
  }
}

final spots = StateProvider<List<FlSpot>>((ref) => []);

_getSpots(WidgetRef ref) {
  /// lets assume x is between 95 to 110 with the interval of 1 to fit in the screen;
  if (ref.watch(optionsContractProvider).isNotEmpty) {
    ref.watch(optionsContractProvider).forEach((e) {
      log("$e");
      for (double x = 95; x <= 110; x += 1) {
        FlSpot spotData = FlSpot(
          x,
          ref.read(optionsContractProvider.notifier).calculateProfitLoss(
                type: e.type,
                x: x,
                strikePrice: e.strikePrice,
                avgOfBidAndAsk: e.avgOfBidAndAsk,
              ),
        );
        if (e.type == optionTypes.call) {}
        ref.read(spots.notifier).state.add(spotData);
      }
    });
  }
}
