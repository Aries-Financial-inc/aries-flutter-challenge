
part of 'option_form_cubit_cubit.dart';


class OptionFormState extends Equatable {
  final double strikePrice;
  final OptionTypes type;
  final double bid;
  final double ask;
  final LongShort longShort;
  final DateTime expirationDate;

  const OptionFormState({
    required this.strikePrice,
    required this.type,
    required this.bid,
    required this.ask,
    required this.longShort,
    required this.expirationDate,
  });

  OptionFormState copyWith({
    double? strikePrice,
    OptionTypes? type,
    double? bid,
    double? ask,
    LongShort? longShort,
    DateTime? expirationDate,
  }) {
    return OptionFormState(
      strikePrice: strikePrice ?? this.strikePrice,
      type: type ?? this.type,
      bid: bid ?? this.bid,
      ask: ask ?? this.ask,
      longShort: longShort ?? this.longShort,
      expirationDate: expirationDate ?? this.expirationDate,
    );
  }

  @override
  List<Object> get props => [
        strikePrice,
        type,
        bid,
        ask,
        longShort,
        expirationDate,
      ];
}
