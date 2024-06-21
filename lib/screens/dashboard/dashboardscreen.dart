// ignore_for_file: must_be_immutable

import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../linker.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMMM d, y h:mma').format(now);
    var provider = Provider.of<OptionsProvider>(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BoxIcon(
                        icon: AppIcon(
                          AppIcons.more,
                          color: unSelectedColor,
                        ),
                        onTap: () => null),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BoxIcon(
                            icon: Icon(
                              Icons.search,
                              color: unSelectedColor,
                            ),
                            onTap: () => null),
                        8.width,
                        Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            image: const DecorationImage(
                              image: AssetImage("assets/images/qwe.jpg"),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                15.height,
                const Text(
                  'Hello, Mabs 👋',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
                ),
                15.height,
                const Porfolio(),
                15.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomWidget.text6(formattedDate, fontSize: 13),
                  ],
                ),
                25.height,
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Stack(
                    children: [
                      RewareLossChart(
                        data: fetchChartData(contracts: provider.contracts),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: appBarBackgroundColorGlobal),
                                child: Icon(Icons.fullscreen,
                                    color: appScaffoldColor))
                            .onTap(() => OptionDetail().launch(context,
                                pageRouteAnimation:
                                    PageRouteAnimation.SlideBottomTop)),
                      )
                    ],
                  ),
                ),
                Center(child: CustomWidget.text6('The remaining code'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BoxIcon extends StatelessWidget {
  Widget icon;
  Function()? onTap;

  BoxIcon({
    super.key,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 40,
          width: 40,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: const Color(0xFFE6E6E6)),
          ),
          child: icon),
    );
  }
}

class Porfolio extends StatelessWidget {
  const Porfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 137,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment(-1.0, -1.0),
          end: Alignment(1.0, 1.0),
          colors: [
            Color(0xFF4567BC),
            Color(0xFFC75DA1),
            Color(0xFFFD6159),
          ],
        ),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomWidget.text5(
                'Your Portfolio',
                fontSize: 14,
              ),
              4.height,
              CustomWidget.text7(
                '\$20,563.02',
                fontSize: 32,
              ),
              4.height,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.arrow_drop_up_sharp,
                    size: 16,
                  ),
                  CustomWidget.text5('8.98% in last 7 days'),
                ],
              )
            ],
          ),
          // 15.width,
          Expanded(
            child: SvgPicture.asset(
              'assets/icons/svg/graph.svg',
            ),
          )
        ],
      ),
    );
  }
}
