import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../linker.dart';

class RewareLossChart extends StatefulWidget {
  RewareLossChart({
    super.key,
    required this.data,
    this.trackballBehavior,
    this.zoomPanBehavior,
    this.tooltipBehavior,
    this.crosshairBehavior,
  });

  CustomChartData data;
  TrackballBehavior? trackballBehavior;
  ZoomPanBehavior? zoomPanBehavior;
  TooltipBehavior? tooltipBehavior;
  CrosshairBehavior? crosshairBehavior;

  @override
  State<RewareLossChart> createState() => _RewareLossChartState();
}

class _RewareLossChartState extends State<RewareLossChart> {
  late TrackballBehavior _trackballBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  late TooltipBehavior _tooltipBehavior;
  late CrosshairBehavior _crosshairBehavior;

  double maxProfit = double.negativeInfinity;
  double maxLoss = double.infinity;
  List<double> breakEvenPoints = [];
  @override
  void initState() {
    super.initState();
    _trackballBehavior = widget.trackballBehavior ??
        TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
          tooltipSettings: const InteractiveTooltip(
            enable: true,
            format: 'point.x : point.y',
          ),
        );

    _zoomPanBehavior = widget.zoomPanBehavior ??
        ZoomPanBehavior(
          enablePinching: true,
          zoomMode: ZoomMode.x,
          enableDoubleTapZooming: true,
        );

    _tooltipBehavior = widget.tooltipBehavior ?? TooltipBehavior(enable: true);

    _crosshairBehavior = widget.crosshairBehavior ??
        CrosshairBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
        );
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      margin: const EdgeInsets.all(0),
      enableAxisAnimation: true,
      legend: const Legend(isVisible: false, position: LegendPosition.bottom),
      primaryXAxis: NumericAxis(
        name: 'Underlying Price',
        labelStyle: TextStyle(color: unSelectedColor),
        labelPosition: ChartDataLabelPosition.outside,
        axisLine: const AxisLine(width: 0),
        majorGridLines:
            const MajorGridLines(width: 0, color: Colors.transparent),
      ),
      primaryYAxis: NumericAxis(
        name: 'Profit/Losse',
        labelPosition: ChartDataLabelPosition.outside,
        labelStyle: TextStyle(color: unSelectedColor),
        axisLine: const AxisLine(width: 0),
        majorGridLines: const MajorGridLines(
            width: 1,
            color: Color(0xFF3F3F3F),
            dashArray: [
              20,
              3,
            ]),
      ),
      series: <CartesianSeries>[
        SplineAreaSeries<ChartData, double>(
          dataSource: widget.data.chartData,
          borderWidth: 3,
          gradient: LinearGradient(
            colors: [Colors.green.withOpacity(0.5), Colors.transparent],
            stops: const [0.0, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          opacity: 0.8,
          borderColor: Colors.green,
          xValueMapper: (ChartData data, _) => data.price,
          yValueMapper: (ChartData data, _) => data.profitLoss,
        ),
      ],
      trackballBehavior: _trackballBehavior,
      zoomPanBehavior: _zoomPanBehavior,
      tooltipBehavior: _tooltipBehavior,
      crosshairBehavior: _crosshairBehavior,
      onChartTouchInteractionMove: (ChartTouchInteractionArgs args) {
        log(args.position.dx.toString());
        log(args.position.dy.toString());
      },
      // onChartTouchInteractionUp: (ChartTouchInteractionArgs args) {
      //   print(args.position.dx.toString());
      //   print(args.position.dy.toString());
      // }
    );
  }
}
