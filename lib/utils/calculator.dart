/// @notice Calculate profits based on option strategy and price of underlying at expiry
/// @param option option strategy with following attribute
///     bid: This is the highest price in the market that a buyer is willing to pay for purchasing options
///     ask: This is the lowest price in the market that a seller is willing to sell their options
///     long_short: whether option is long or short
///     type: whether option is call or put
/// @return profit
double calculateProfits(Map<String, dynamic> option, double price) {

  double strikePrice = option["strike_price"].toDouble();
  double bid = option["bid"].toDouble();
  double ask = option["ask"].toDouble();
  bool isLong = option["long_short"] == "long";
  bool isCall = option["type"] == "Call";

  double premium = ask - bid;

    // Long Call Option
    if (isLong && isCall) {
        /* 
            For Long call Option
            if underlying(stock)'s price is less than strike price, 
            traders should pay premium only, so loss is premium.
                profit = -premium (loss)

            if underlying(stock)'s price is higher than strike price, 
            user can exercise strike price to purchase stock. 
            
                profit = (underlying's price - strike) - premium
        */       
        if (price <= strikePrice) {
          return -premium;
        } else {
          return price - strikePrice - premium;
        }

    } else if (isLong && !isCall) {
        /* 
            For Long put Option
            if underlying(stock)'s price is higher than strike price, 
            traders should pay premium only so loss is premium.
                profit = -premium (loss)
            
            if underlying(stock)'s price is less than strike price, 
            user can exercise strike price to purchase stock. 

                profit = (strike - underlying's price) - premium
        */

        if (price >= strikePrice) {
          return -premium;
        } else {
          return strikePrice - price - premium;
        }


    } else if (!isLong && isCall) {
        /* 
            For Short Call Option
            if underlying(stock)'s price is less than strike price,
            a buyer doesn't purchase his asset, so seller only receives premium
                profit = premium 

            if underlying(stock)'s price is less than strike price,
            a buyer purchases his asset and he receives decreased premium. 

                profit = premium - (underlying's price - strike)
        */

        if (price <= strikePrice) {
          return premium;
        } else {
          return premium - (price - strikePrice);
        }

    } else {
        /* 
            For Short Put Option
            if underlying(stock)'s price is higher than strike price,
            a buyer doesn't purchase his asset, so seller only receives premium

                profit = premium 

            if underlying(stock)'s price is less than strike price,
            a buyer purchases his asset and he receives decreased premium. 
            
                profit = premium - (strike - underlying's price)
        */

        if (price >= strikePrice) {
          return premium;
        } else {
          return premium - (strikePrice - price);
        }

    }

}

/// @notice Calculate features of option strategy
/// @param option option strategy with following attribute
///     bid: This is the highest price in the market that a buyer is willing to pay for purchasing options
///     ask: This is the lowest price in the market that a seller is willing to sell their options
///     long_short: whether option is long or short
///     type: whether option is call or put
/// @return {breakeven, max_profit, max_loss}
Feature calculateFeature(option) {
  double strikePrice = option["strike_price"].toDouble();
  double bid = option["bid"].toDouble();
  double ask = option["ask"].toDouble();
  bool isLong = option["long_short"] == "long";
  bool isCall = option["type"] == "Call";

  double premium = ask - bid;
  double breakeven, loss, profit;
  if (isCall) {
      /*  
          profit = (underlying's price - strike) - premium
          profit = 0 (at breakeven) => underlying's price = strike + premium 
      */
      breakeven = strikePrice + premium;

  } else {
      /* 
          profit = (strike - underlying's price) - premium
          profit = 0 (at breakeven) => underlying's price = strike - premium 
      */
      breakeven = strikePrice - premium;
  }

  if (isLong) {
      /*
          if option is not exercised, trader should pay premium only, so max of loss will be premium. 
      */
      loss = -premium;
      /*
          function of profit will be linear, so we can denote it as the follwing
          Y = AX + B, 
          Y1 = AX1 + B
          Y2 = AX2 + B
          Y1 - Y2 = A(X1 - X2) => 
              A = (Y1 - Y2) / (X1 - X2), 
              B = Y1 - A * X1

          X1 = breakeven, X2 = strike => Y1 = 0, Y2 = -premium
          
          A = premium / (br - st)
          B = -A * X1 = -br * premium / (br - st) = br * premium / premium = br  

          in case of long call option
          B = br (max profit will be taken in zero price) 
      */
      if (isCall) {
        profit = double.infinity;
      } else {
        profit = breakeven;
      }
      
  } else {
      /*
          if sell option is not exercised, trader will get paid premium only from a buyer.
      */
      profit = premium;
      /*
          function of profit will be linear, so we can denote it as the follwing
          Y = AX + B, 
          Y1 = AX1 + B
          Y2 = AX2 + B
          Y1 - Y2 = A(X1 - X2) => 
              A = (Y1 - Y2) / (X1 - X2), 
              B = Y1 - A * X1

          X1 = breakeven, X2 = strike => Y1 = 0, Y2 = premium
              A = -premium / (br - st), 
              B = - A * br = premium * br / (br - st) = -br

          in case of short put option
          B = -br(max loss will be occured in zero price)              
      */
      if (isCall) {
        loss = double.infinity;
      } else {
        loss = -breakeven;
      }
  }

  return Feature(maxProfit : profit, maxLoss: loss, breakeven: breakeven);
}

class Feature {
  final double maxProfit;
  final double maxLoss;
  final double breakeven;

  const Feature({
    required this.breakeven, 
    required this.maxProfit, 
    required this.maxLoss
  });

}
