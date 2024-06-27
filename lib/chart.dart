import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_challenge/main.dart';




// profit as function of time
// make list of points length with length of sws and form [x,y] e.g.   [[1,2], [3,4] ... ]
 calc_profit( del_t , sws, sa, set_prem, prem_rate, stock_stdelta, ncocd_rate_stdelta, strike_price){
  print("calc profit called");
  assert(sws.floor().isEven, "graph window size must be even");
  List<List<dynamic>> plot_pnts = [];

  /// formula for pdf
  // /// we will divide by t since normalized over period
  // pdf_STD_NormDist(mean, std_dev, curr_point_price){
  //   double pdf_second_term = - math.pow(math.e, - ( ( math.pow((  ), 2)) /
  //       (2 * math.pow( (stock_stdelta) , 2 ))  ) ).toDouble();
  //
  //   return ( 1 / ( stock_stdelta  * math.pow( ( 2 * math.pi ), .5 ))) *  math.pow(math.e, pdf_second_term) ;
  // }

/// use a sum of variances to estimate risk drift
  /// approximate three variance periods in the del_t ()
  double variance_risk_NormDist(del_t){
    return math.pow( ( math.pow(stock_stdelta , 2) * del_t ) , .5).toDouble();
  }


  /// build graph points
  int iter = sws ;
  while (iter >= 0  ){
    print("looping iteritem ~ " + iter.toString());
    // print("iter slope ~ " + curr_exp_side_slope.toString());

    double x_axis_market_price  =  (iter).toDouble();

    double y_axis_profit        =  0;


    double get_est_jitter = variance_risk_NormDist(del_t);
      print("GET EST RISK ~ " + get_est_jitter.toString());

    /// point price ( on graph ) =  shares_amount *  base movement   + estimated risk (for stock and interest volatility ... set below)
    double pprice =  ( x_axis_market_price - strike_price ) ;


    if (iter == sws + 1){
      /// init to bounds
      y_axis_profit = sws;
    }

    else {

      /// CASE ABOVE STRIKE PRICE
      /// stitch together solutions around break even point
      if (iter >= (sws / 2)) {

        /// introduce a term that accounts for the risk/reward of longer expiry options and the standard deviation
        double pl_term = (1/strike_price) * math.pow( x_axis_market_price - 100 , 2)  *  get_est_jitter ;
        // double pl_term = ( 200 - iter  ) * ( 1 / ( sws/2 ) ) *  get_est_jitter ;
        // print("GET First PL TERM ~ " + pl_term.toString());

          if (iter == sws/2){
            print("setting mid point slope");
          }
        // print(" calc ~   PROFIT =  pprice: $pprice   curr_exp_side_slope: $curr_exp_side_slope   estimate_risk_dist: $estimate_risk_dist ");

        /// just use a step size of one
        y_axis_profit = pprice + pl_term;

        /// cap to premium in first side of strike price
        if (y_axis_profit < - set_prem){
          y_axis_profit  = - (set_prem).toDouble() + pl_term;
        }
      }


      /// CASE BELOW STRIKE PRICE

      if (iter < (sws / 2)) {

        double pl_term = ( iter  ) * ( 1 / ( sws/2 ) ) *  get_est_jitter ;
        // print("GET SECONDARY PL TERM ~ " + pl_term.toString());


        /// out of the money add constraint to factor in expire without excercise ( approach premium asymptote )
          if (plot_pnts.length > 1) {
            // print("len greater than one do calc");
            y_axis_profit = pprice + pl_term;

          }
          else {
            // print("else last just set to zero");
            /// cap to premium in second side of strike price
            y_axis_profit = - set_prem.toDouble() + pl_term;
          }


          /// condition for maximum loss cap
          if ( y_axis_profit <  - set_prem ) {
            y_axis_profit = -(set_prem).toDouble() + pl_term;
          }

      }
    }


    /// the point object
    List pobj = [x_axis_market_price, y_axis_profit * sa];
    plot_pnts.add(pobj);

    iter -= 1;

    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

  }

  return plot_pnts;

}

