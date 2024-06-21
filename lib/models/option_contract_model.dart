import 'package:flutter_challenge/linker.dart';

class OptionContract {
  final String type; // 'call' or 'put'
  final String longShort; // 'long' or 'short'
  final double strikePrice;
  final double
      premium; // Average of bid and ask prices (bid+ask)/2      PLEASE NOTE: I'M NOT SURE
  final DateTime expireDate;
  final double ask;
  final double bid;
  final int? quantity;

  OptionContract({
    required this.type,
    required this.ask,
    required this.bid,
    required this.strikePrice,
    required this.longShort,
    required this.premium,
    this.quantity,
    required this.expireDate,
  });

  factory OptionContract.fromJson(Map<String, dynamic> json) {
    double bid = (json['bid'] as num?)?.toDouble() ?? 0.0;
    double ask = (json['ask'] as num?)?.toDouble() ?? 0.0;
    double premium = (bid + ask) / 2;
    return OptionContract(
      type: (json['type'] as String?)?.capitalizeFirstLetter() ?? '',
      strikePrice: (json['strike_price'] as num?)?.toDouble() ?? 0.0,
      ask: ask,
      bid: bid,
      longShort: (json['long_short'] as String?)?.capitalizeFirstLetter() ?? '',
      expireDate: DateTime.parse(
          json['expiration_date'] ?? DateTime.now().toIso8601String()),
      premium: premium,
    );
  }
}
