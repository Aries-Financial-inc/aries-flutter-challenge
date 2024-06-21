// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OptionContract _$OptionContractFromJson(Map<String, dynamic> json) {
  return _OptionContract.fromJson(json);
}

/// @nodoc
mixin _$OptionContract {
  @JsonKey(name: 'strike_price')
  num get strikePrice => throw _privateConstructorUsedError;
  OptionType get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'long_short')
  LongShort get longShort => throw _privateConstructorUsedError;
  num get bid => throw _privateConstructorUsedError;
  num get ask => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OptionContractCopyWith<OptionContract> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OptionContractCopyWith<$Res> {
  factory $OptionContractCopyWith(
          OptionContract value, $Res Function(OptionContract) then) =
      _$OptionContractCopyWithImpl<$Res, OptionContract>;
  @useResult
  $Res call(
      {@JsonKey(name: 'strike_price') num strikePrice,
      OptionType type,
      @JsonKey(name: 'long_short') LongShort longShort,
      num bid,
      num ask});
}

/// @nodoc
class _$OptionContractCopyWithImpl<$Res, $Val extends OptionContract>
    implements $OptionContractCopyWith<$Res> {
  _$OptionContractCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? strikePrice = null,
    Object? type = null,
    Object? longShort = null,
    Object? bid = null,
    Object? ask = null,
  }) {
    return _then(_value.copyWith(
      strikePrice: null == strikePrice
          ? _value.strikePrice
          : strikePrice // ignore: cast_nullable_to_non_nullable
              as num,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as OptionType,
      longShort: null == longShort
          ? _value.longShort
          : longShort // ignore: cast_nullable_to_non_nullable
              as LongShort,
      bid: null == bid
          ? _value.bid
          : bid // ignore: cast_nullable_to_non_nullable
              as num,
      ask: null == ask
          ? _value.ask
          : ask // ignore: cast_nullable_to_non_nullable
              as num,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OptionContractImplCopyWith<$Res>
    implements $OptionContractCopyWith<$Res> {
  factory _$$OptionContractImplCopyWith(_$OptionContractImpl value,
          $Res Function(_$OptionContractImpl) then) =
      __$$OptionContractImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'strike_price') num strikePrice,
      OptionType type,
      @JsonKey(name: 'long_short') LongShort longShort,
      num bid,
      num ask});
}

/// @nodoc
class __$$OptionContractImplCopyWithImpl<$Res>
    extends _$OptionContractCopyWithImpl<$Res, _$OptionContractImpl>
    implements _$$OptionContractImplCopyWith<$Res> {
  __$$OptionContractImplCopyWithImpl(
      _$OptionContractImpl _value, $Res Function(_$OptionContractImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? strikePrice = null,
    Object? type = null,
    Object? longShort = null,
    Object? bid = null,
    Object? ask = null,
  }) {
    return _then(_$OptionContractImpl(
      strikePrice: null == strikePrice
          ? _value.strikePrice
          : strikePrice // ignore: cast_nullable_to_non_nullable
              as num,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as OptionType,
      longShort: null == longShort
          ? _value.longShort
          : longShort // ignore: cast_nullable_to_non_nullable
              as LongShort,
      bid: null == bid
          ? _value.bid
          : bid // ignore: cast_nullable_to_non_nullable
              as num,
      ask: null == ask
          ? _value.ask
          : ask // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OptionContractImpl extends _OptionContract {
  const _$OptionContractImpl(
      {@JsonKey(name: 'strike_price') required this.strikePrice,
      required this.type,
      @JsonKey(name: 'long_short') required this.longShort,
      required this.bid,
      required this.ask})
      : super._();

  factory _$OptionContractImpl.fromJson(Map<String, dynamic> json) =>
      _$$OptionContractImplFromJson(json);

  @override
  @JsonKey(name: 'strike_price')
  final num strikePrice;
  @override
  final OptionType type;
  @override
  @JsonKey(name: 'long_short')
  final LongShort longShort;
  @override
  final num bid;
  @override
  final num ask;

  @override
  String toString() {
    return 'OptionContract(strikePrice: $strikePrice, type: $type, longShort: $longShort, bid: $bid, ask: $ask)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OptionContractImpl &&
            (identical(other.strikePrice, strikePrice) ||
                other.strikePrice == strikePrice) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.longShort, longShort) ||
                other.longShort == longShort) &&
            (identical(other.bid, bid) || other.bid == bid) &&
            (identical(other.ask, ask) || other.ask == ask));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, strikePrice, type, longShort, bid, ask);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OptionContractImplCopyWith<_$OptionContractImpl> get copyWith =>
      __$$OptionContractImplCopyWithImpl<_$OptionContractImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OptionContractImplToJson(
      this,
    );
  }
}

abstract class _OptionContract extends OptionContract {
  const factory _OptionContract(
      {@JsonKey(name: 'strike_price') required final num strikePrice,
      required final OptionType type,
      @JsonKey(name: 'long_short') required final LongShort longShort,
      required final num bid,
      required final num ask}) = _$OptionContractImpl;
  const _OptionContract._() : super._();

  factory _OptionContract.fromJson(Map<String, dynamic> json) =
      _$OptionContractImpl.fromJson;

  @override
  @JsonKey(name: 'strike_price')
  num get strikePrice;
  @override
  OptionType get type;
  @override
  @JsonKey(name: 'long_short')
  LongShort get longShort;
  @override
  num get bid;
  @override
  num get ask;
  @override
  @JsonKey(ignore: true)
  _$$OptionContractImplCopyWith<_$OptionContractImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProfitLossData _$ProfitLossDataFromJson(Map<String, dynamic> json) {
  return _ProfitLossData.fromJson(json);
}

/// @nodoc
mixin _$ProfitLossData {
  double get underlyingPrice => throw _privateConstructorUsedError;
  double get profitLoss => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfitLossDataCopyWith<ProfitLossData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfitLossDataCopyWith<$Res> {
  factory $ProfitLossDataCopyWith(
          ProfitLossData value, $Res Function(ProfitLossData) then) =
      _$ProfitLossDataCopyWithImpl<$Res, ProfitLossData>;
  @useResult
  $Res call({double underlyingPrice, double profitLoss});
}

/// @nodoc
class _$ProfitLossDataCopyWithImpl<$Res, $Val extends ProfitLossData>
    implements $ProfitLossDataCopyWith<$Res> {
  _$ProfitLossDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? underlyingPrice = null,
    Object? profitLoss = null,
  }) {
    return _then(_value.copyWith(
      underlyingPrice: null == underlyingPrice
          ? _value.underlyingPrice
          : underlyingPrice // ignore: cast_nullable_to_non_nullable
              as double,
      profitLoss: null == profitLoss
          ? _value.profitLoss
          : profitLoss // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfitLossDataImplCopyWith<$Res>
    implements $ProfitLossDataCopyWith<$Res> {
  factory _$$ProfitLossDataImplCopyWith(_$ProfitLossDataImpl value,
          $Res Function(_$ProfitLossDataImpl) then) =
      __$$ProfitLossDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double underlyingPrice, double profitLoss});
}

/// @nodoc
class __$$ProfitLossDataImplCopyWithImpl<$Res>
    extends _$ProfitLossDataCopyWithImpl<$Res, _$ProfitLossDataImpl>
    implements _$$ProfitLossDataImplCopyWith<$Res> {
  __$$ProfitLossDataImplCopyWithImpl(
      _$ProfitLossDataImpl _value, $Res Function(_$ProfitLossDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? underlyingPrice = null,
    Object? profitLoss = null,
  }) {
    return _then(_$ProfitLossDataImpl(
      underlyingPrice: null == underlyingPrice
          ? _value.underlyingPrice
          : underlyingPrice // ignore: cast_nullable_to_non_nullable
              as double,
      profitLoss: null == profitLoss
          ? _value.profitLoss
          : profitLoss // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfitLossDataImpl implements _ProfitLossData {
  const _$ProfitLossDataImpl(
      {required this.underlyingPrice, required this.profitLoss});

  factory _$ProfitLossDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfitLossDataImplFromJson(json);

  @override
  final double underlyingPrice;
  @override
  final double profitLoss;

  @override
  String toString() {
    return 'ProfitLossData(underlyingPrice: $underlyingPrice, profitLoss: $profitLoss)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfitLossDataImpl &&
            (identical(other.underlyingPrice, underlyingPrice) ||
                other.underlyingPrice == underlyingPrice) &&
            (identical(other.profitLoss, profitLoss) ||
                other.profitLoss == profitLoss));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, underlyingPrice, profitLoss);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfitLossDataImplCopyWith<_$ProfitLossDataImpl> get copyWith =>
      __$$ProfitLossDataImplCopyWithImpl<_$ProfitLossDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfitLossDataImplToJson(
      this,
    );
  }
}

abstract class _ProfitLossData implements ProfitLossData {
  const factory _ProfitLossData(
      {required final double underlyingPrice,
      required final double profitLoss}) = _$ProfitLossDataImpl;

  factory _ProfitLossData.fromJson(Map<String, dynamic> json) =
      _$ProfitLossDataImpl.fromJson;

  @override
  double get underlyingPrice;
  @override
  double get profitLoss;
  @override
  @JsonKey(ignore: true)
  _$$ProfitLossDataImplCopyWith<_$ProfitLossDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
