// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'risk_and_reward_state_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RiskAndRewardState _$RiskAndRewardStateFromJson(Map<String, dynamic> json) {
  return _RiskAndRewardState.fromJson(json);
}

/// @nodoc
mixin _$RiskAndRewardState {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RiskAndRewardStateCopyWith<RiskAndRewardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RiskAndRewardStateCopyWith<$Res> {
  factory $RiskAndRewardStateCopyWith(
          RiskAndRewardState value, $Res Function(RiskAndRewardState) then) =
      _$RiskAndRewardStateCopyWithImpl<$Res, RiskAndRewardState>;
  @useResult
  $Res call({bool isLoading, String? id});
}

/// @nodoc
class _$RiskAndRewardStateCopyWithImpl<$Res, $Val extends RiskAndRewardState>
    implements $RiskAndRewardStateCopyWith<$Res> {
  _$RiskAndRewardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RiskAndRewardStateImplCopyWith<$Res>
    implements $RiskAndRewardStateCopyWith<$Res> {
  factory _$$RiskAndRewardStateImplCopyWith(_$RiskAndRewardStateImpl value,
          $Res Function(_$RiskAndRewardStateImpl) then) =
      __$$RiskAndRewardStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, String? id});
}

/// @nodoc
class __$$RiskAndRewardStateImplCopyWithImpl<$Res>
    extends _$RiskAndRewardStateCopyWithImpl<$Res, _$RiskAndRewardStateImpl>
    implements _$$RiskAndRewardStateImplCopyWith<$Res> {
  __$$RiskAndRewardStateImplCopyWithImpl(_$RiskAndRewardStateImpl _value,
      $Res Function(_$RiskAndRewardStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? id = freezed,
  }) {
    return _then(_$RiskAndRewardStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RiskAndRewardStateImpl
    with DiagnosticableTreeMixin
    implements _RiskAndRewardState {
  _$RiskAndRewardStateImpl({this.isLoading = false, this.id});

  factory _$RiskAndRewardStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$RiskAndRewardStateImplFromJson(json);

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? id;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RiskAndRewardState(isLoading: $isLoading, id: $id)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RiskAndRewardState'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('id', id));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RiskAndRewardStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, isLoading, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RiskAndRewardStateImplCopyWith<_$RiskAndRewardStateImpl> get copyWith =>
      __$$RiskAndRewardStateImplCopyWithImpl<_$RiskAndRewardStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RiskAndRewardStateImplToJson(
      this,
    );
  }
}

abstract class _RiskAndRewardState implements RiskAndRewardState {
  factory _RiskAndRewardState({final bool isLoading, final String? id}) =
      _$RiskAndRewardStateImpl;

  factory _RiskAndRewardState.fromJson(Map<String, dynamic> json) =
      _$RiskAndRewardStateImpl.fromJson;

  @override
  bool get isLoading;
  @override
  String? get id;
  @override
  @JsonKey(ignore: true)
  _$$RiskAndRewardStateImplCopyWith<_$RiskAndRewardStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
