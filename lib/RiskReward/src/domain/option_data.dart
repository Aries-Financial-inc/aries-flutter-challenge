// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';

class OptionData extends Equatable {
  final double strikePrice;
  final String type;
  final double bid;
  final double ask;
  final String longShort;
  final DateTime expirationDate;

  const OptionData({
    required this.strikePrice,
    required this.type,
    required this.bid,
    required this.ask,
    required this.longShort,
    required this.expirationDate,
  });

  @override
  List<Object?> get props => [
        strikePrice,
        type,
        bid,
        ask,
        longShort,
        expirationDate,
      ];
}
