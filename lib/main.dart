import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_challenge/chart.dart';

/// params trying to use from black scholes
///  time until maturity
///  risk/time
///  price(time)
///  strike price
///  risk-free interest rate


/// reference meta options pricing
/// (buy call) base_price: 512,  strike:  512.5  , ask: 5.05,  breakeven: 517.4,  exp_time: 1 day,
///
/// /// (buy call) base_price: 512,  strike:  515  , ask: 3.80,  breakeven: 518.7,  exp_time: 1 day,



lg(String msg){
  debugPrint(msg, wrapWidth: 1024);
}


Size ss = Size(0,0);

/// options drop down values
List spDDList= [90,100,110];
List etDDList = [1, 5, 10, 30 ];
List saDDList = [1, 3, 5, 8, 13 ];


void main() {
  runApp(const Root());
}


class Root extends StatelessWidget {
  const Root({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Options Risk Plot Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AppHome(),
    );
  }
}

class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}


class _AppHomeState extends State<AppHome> {





  // the amount of time elapsed into contract W/ units ( day )
  /// one option ( allows the graph to expand 'stochastically' depending on our historical signals )
  int del_t = 200;

  // size of graph x axis ( they go to infinity so it's arbitrary )
  int plot_x_size = 200;

  // shares amount
  int sa = 11;

  // premium (set based off shares amount later
  double set_prem = 5;

  // rate of premium ( used to set_prem )
  double prem_rate = .05;

  // historical stock std dev
  double stock_stdelta =  42;

  // historical interest rate st dev normalized for period
  double ncocd_rate_stdelta = .5;

  /// another option ( )
  double strike_price = 100;



  List<List>? chartData0;
  List<List>? chartData1;

  /// the initial strike value
  int strikePriceDropDownInputValue = 100;
  /// in days
  int expiryDropDownInputValue = 1 ;
  int quantDropDownInputValue = 1;

  initPLChart(){
    print("initPLChart called");
    var res0 = calc_profit(del_t, plot_x_size, sa, set_prem, prem_rate, stock_stdelta, ncocd_rate_stdelta, strike_price);
    lg("res0 ~ " + res0.toString());

    // var res1 = calc_profit(200, 200, 11, 5, .05, 80.0, 15.0, 150.0);

    Future.delayed(Duration.zero,() {
      if (mounted) {
        setState(() {
          chartData0 = res0;
        });
      }
    });
  }

  @override
  void initState() {
    print("Init main.dart");
    set_prem =  prem_rate * ( strike_price * sa );
    print("call initPLChart");
    initPLChart();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("GET SA ~ " + sa.toString());

    if (chartData0 == null){
      return Scaffold(body: Container());
    }

    ss = MediaQuery.of(context).size;


    set_prem =  prem_rate * ( strike_price * sa );


    final List<List> chartDataInt0 = chartData0!.map((point){

      int intPointX = 99;
      int intPointY = 99;
      if (point[0] != double.infinity) {
        intPointX = point[0].floor()??0;
      }
      if (point[1] != double.infinity) {
        intPointY = point[1].floor()??0;
      }

      // print(" POINT ~ " + intPointX.toString() + "," + intPointY.toString());
      return [intPointX, intPointY];
    }).toList();



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Call Option PL Demo"),
      ),
      body: ListView(
          children:[
            SfCartesianChart(
              title: ChartTitle(text: 'Option Profit Prediction 0'),
              primaryXAxis: const NumericAxis(),
              primaryYAxis: const NumericAxis(),
              series: <CartesianSeries<List, int>>[
              LineSeries<List, int>(
                dataSource: chartDataInt0,
                markerSettings: const MarkerSettings(isVisible: false),
                xValueMapper: (List data, _) => data[0],
                yValueMapper: (List data, _) => data[1],
                // xAxisName: "Price",
                // yAxisName: "P/L",
              ),

                ],
              ),



            SizedBox(height: ss.width * .15,),

        Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
              Text("Strike Price")]),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: ss.width * .1),
                child:DropdownButton<int>(
            value: strikePriceDropDownInputValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
            ),
            onChanged: (int? value) {
            // This is called when the user selects an item.

            setState(() {
            strikePriceDropDownInputValue = value!;
            strike_price = value.toDouble();
            });
            initPLChart();
            },
            items:
    spDDList.map((value) {
            return DropdownMenuItem<int>(
            value: value,
            child: Text(value.toString()),
            );
            }).toList(),
            )),


            SizedBox(height: ss.width * .15,),


            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[Text("Expiry Time"),]),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ss.width * .1),
                  child:DropdownButton<int>(
                  isDense: true,
                  value: expiryDropDownInputValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (int? value) {
                    // This is called when the user selects an item.

                    setState(() {
                      expiryDropDownInputValue = value!;
                      del_t = value;
                    });
                    initPLChart();
                  },
                  items:
                  etDDList.map((value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                )),


            SizedBox(height: ss.width * .15,),


            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[Text("Quantity"),]),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: ss.width * .1),
                child:DropdownButton<int>(
                  isDense: true,
                  value: quantDropDownInputValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (int? value) {
                    // This is called when the user selects an item.

                    setState(() {
                      quantDropDownInputValue = value!;
                      sa = value;
                    });
                    initPLChart();
                  },
                  items:
                  saDDList.map((value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ))





          ]


      ));
  }
}



