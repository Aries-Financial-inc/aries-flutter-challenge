class OptionContract {
  final String type; // 'call' or 'put'
  final double strikePrice;
  final double premium;
  final int quantity;
  final DateTime expiryDate;

  OptionContract({
    required this.type,
    required this.strikePrice,
    required this.premium,
    required this.quantity,
    required this.expiryDate,
  });
}
