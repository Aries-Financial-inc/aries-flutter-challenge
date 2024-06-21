class OptionContract {
  final double strikePrice;
  final String type; // "Call" or "Put"
  final double bid;
  final double ask;
  final String longShort; // "long" or "short"
  final DateTime expirationDate;

  OptionContract({
    required this.strikePrice,
    required this.type,
    required this.bid,
    required this.ask,
    required this.longShort,
    required this.expirationDate,
  });

  // Factory method to create an OptionContract from a Map
  factory OptionContract.fromJson(Map<String, dynamic> json) {
    return OptionContract(
      strikePrice: json['strike_price'].toDouble(),
      type: json['type'] as String,
      bid: json['bid'].toDouble(),
      ask: json['ask'].toDouble(),
      longShort: json['long_short'] as String,
      expirationDate: DateTime.parse(json['expiration_date'] as String),
    );
  }

  // Method to convert OptionContract to Map (for serialization)
  Map<String, dynamic> toJson() {
    return {
      'strike_price': strikePrice,
      'type': type,
      'bid': bid,
      'ask': ask,
      'long_short': longShort,
      'expiration_date': expirationDate.toIso8601String(),
    };
  }
}
