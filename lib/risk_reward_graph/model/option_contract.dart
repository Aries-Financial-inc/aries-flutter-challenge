enum OptionType { call, put }

enum OptionPosition { long, short }

class OptionContractModel {
  final double strikePrice;
  final OptionType type; // "Call" or "Put"
  final double bid;
  final double ask;
  final OptionPosition position; // "long" or "short"
  final String expirationDate;

  OptionContractModel({
    required this.strikePrice,
    required this.type,
    required this.bid,
    required this.ask,
    required this.position,
    required this.expirationDate,
  });

  // Factory method to create an OptionContract from a Map
  factory OptionContractModel.fromJson(Map<String, dynamic> json) {
    return OptionContractModel(
      strikePrice: json['strike_price'].toDouble(),
      type: _parseOptionType(json['type']),
      bid: json['bid'].toDouble(),
      ask: json['ask'].toDouble(),
      position: _parseOptionPosition(json['long_short']),
      expirationDate: json['expiration_date'],
    );
  }

  // Method to convert OptionContract to Map (for serialization)
  Map<String, dynamic> toJson() {
    return {
      'strike_price': strikePrice,
      'type': type,
      'bid': bid,
      'ask': ask,
      'long_short': position,
      'expiration_date': expirationDate,
    };
  }

  bool get isLong => position == OptionPosition.long;
  bool get isCall => type == OptionType.call;

  static OptionType _parseOptionType(String optionTypeString) {
    if (optionTypeString.toLowerCase() == 'call') {
      return OptionType.call;
    } else if (optionTypeString.toLowerCase() == 'put') {
      return OptionType.put;
    } else {
      throw ArgumentError('Invalid option type string: $optionTypeString');
    }
  }

  static OptionPosition _parseOptionPosition(String pos) {
    if (pos.toLowerCase() == 'long') {
      return OptionPosition.long;
    } else if (pos.toLowerCase() == 'short') {
      return OptionPosition.short;
    } else {
      throw ArgumentError('Invalid option type string: $pos');
    }
  }
}
