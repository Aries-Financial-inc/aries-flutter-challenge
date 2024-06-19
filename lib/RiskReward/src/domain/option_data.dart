class OptionData {
  final double strikePrice;
  final String type;
  final double bid;
  final double ask;
  final String longShort;
  final DateTime expirationDate;

  OptionData(
      {required this.strikePrice,
      required this.type,
      required this.bid,
      required this.ask,
      required this.longShort,
      required this.expirationDate});
}
