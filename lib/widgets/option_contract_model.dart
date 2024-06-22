class OptionContract {
  final num strikePrice;
  final double premium;
  final bool isCall;
  final bool isLong;
  final DateTime expirationDate;

  OptionContract({
    required this.strikePrice,
    required this.premium,
    required this.isCall,
    required this.isLong,
    required this.expirationDate,
  });

  factory OptionContract.fromJson(Map<String, dynamic> json) {
    return OptionContract(
      strikePrice: json['strike_price'],
      premium:
          (json['bid'] + json['ask']) / 2, // average of bid and ask as premium
      isCall: json['type'] == 'Call',
      isLong: json['long_short'] == 'long',
      expirationDate: DateTime.parse(json['expiration_date']),
    );
  }
}
