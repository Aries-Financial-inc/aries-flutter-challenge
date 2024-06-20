enum OptionType { call, put }

enum LongShort { long, short }

class OptionContract {
  final double strikePrice;
  final OptionType type;
  final double bid;
  final double ask;
  final LongShort longShort;
  final DateTime expirationDate;

  OptionContract({
    required this.strikePrice,
    required this.type,
    required this.bid,
    required this.ask,
    required this.longShort,
    required this.expirationDate,
  });

  factory OptionContract.fromMap(Map<String, dynamic> map) {
    return OptionContract(
      strikePrice: map['strike_price'],
      type: map['type'],
      bid: map['bid'],
      ask: map['ask'],
      longShort: map['long_short'],
      expirationDate: DateTime.parse(map['expiration_date']),
    );
  }
}

class OptionContractDTO {
  final double strikePrice;
  final OptionType type;
  final double bid;
  final double ask;
  final LongShort longShort;
  final DateTime expirationDate;

  OptionContractDTO({
    required this.type,
    required this.strikePrice,
    required this.bid,
    required this.ask,
    required this.longShort,
    required this.expirationDate,
  });

  OptionContract toDomain() {
    return OptionContract(
      type: type,
      strikePrice: strikePrice,
      bid: bid,
      ask: ask,
      longShort: longShort,
      expirationDate: expirationDate,
    );
  }

  // Factory constructor to create OptionContractDTO from JSON.
  factory OptionContractDTO.fromJson(Map<String, dynamic> json) {
    return OptionContractDTO(
      type: json['type'].toString().toLowerCase() == 'call'
          ? OptionType.call
          : OptionType.put,
      strikePrice: json['strike_price'].toDouble(),
      bid: json['bid'].toDouble(),
      ask: json['ask'].toDouble(),
      longShort: json['long_short'].toString().toLowerCase() == 'long'
          ? LongShort.long
          : LongShort.short,
      expirationDate: DateTime.parse(json['expiration_date']),
    );
  }
}
