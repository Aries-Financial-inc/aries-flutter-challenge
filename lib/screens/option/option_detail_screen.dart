import 'package:flutter_challenge/screens/option/component/table.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../linker.dart';
import '../dashboard/dashboardscreen.dart';
import 'optioncalculator.dart';

// TODO ADD LOADING SHIMMER
class OptionDetail extends StatefulWidget {
  bool isNav;

  OptionDetail({
    this.isNav = false,
    super.key,
  });

  @override
  State<OptionDetail> createState() => _OptionDetailState();
}

class _OptionDetailState extends State<OptionDetail> {
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
    _trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
      tooltipSettings: const InteractiveTooltip(
        enable: true,
        format: 'point.x : point.y',
      ),
    );

    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      zoomMode: ZoomMode.x,
      enableDoubleTapZooming: true,
    );

    _tooltipBehavior = TooltipBehavior(enable: true);

    _crosshairBehavior = CrosshairBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<OptionsProvider>(context);

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMMM d, y h:mma').format(now);
    return PopScope(
      canPop: !widget.isNav,
      child: Scaffold(
          appBar: AppBar(
            title:
                CustomWidget.text6("Options Profit Calculator", fontSize: 18),
            centerTitle: false,
            automaticallyImplyLeading: !widget.isNav,
            actions: [
              BoxIcon(
                  icon: Icon(
                    Icons.add,
                    color: unSelectedColor,
                  ),
                  onTap: () => AddOptionSheet(
                        onAddOption: (oc) {
                          log(provider.contracts.length);
                          provider.addContract(oc);
                          log(provider.contracts.length);
                          setState(() {});
                        },
                      ).launch(context)),
              8.width,
              BoxIcon(
                  icon: Icon(
                    Icons.settings,
                    color: unSelectedColor,
                  ),
                  onTap: () => null),
              8.width,
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.height,
                CustomWidget.text6(formattedDate, fontSize: 13).onTap(() {
                  provider.co();
                }),
                30.height,
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  // Reusable app chart
                  child: RewareLossChart(
                      data: fetchChartData(
                          contracts: provider.contracts,
                          maxLoss: maxLoss,
                          maxProfit: maxProfit),
                      trackballBehavior: _trackballBehavior,
                      zoomPanBehavior: _zoomPanBehavior,
                      tooltipBehavior: _tooltipBehavior,
                      crosshairBehavior: _crosshairBehavior),
                ),
                15.height,
                CustomWidget.text6('Options', fontSize: 16),
                15.height,
                // Option table
                OptionsTable(provider: provider)
              ],
            ),
          )),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chart Settings'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CheckboxListTile(
                title: const Text("Enable Trackball"),
                value: _trackballBehavior.enable,
                onChanged: (bool? value) {
                  setState(() {
                    // _trackballBehavior.enable = true;
                    // value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text("Enable Crosshair"),
                value: _crosshairBehavior.enable,
                onChanged: (bool? value) {
                  setState(() {
                    _crosshairBehavior = CrosshairBehavior(
                      enable: value!,
                      activationMode: ActivationMode.singleTap,
                    );
                  });
                },
              ),
              CheckboxListTile(
                title: const Text("Enable Tooltip"),
                value: _tooltipBehavior.enable,
                onChanged: (bool? value) {
                  setState(() {
                    _tooltipBehavior = TooltipBehavior(enable: value!);
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
