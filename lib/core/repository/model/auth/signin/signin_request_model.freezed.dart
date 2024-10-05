// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signin_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SignInRequestModel _$SignInRequestModelFromJson(Map<String, dynamic> json) {
  return _SignInRequestModel.fromJson(json);
}

/// @nodoc
mixin _$SignInRequestModel {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  /// Serializes this SignInRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SignInRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignInRequestModelCopyWith<SignInRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignInRequestModelCopyWith<$Res> {
  factory $SignInRequestModelCopyWith(
          SignInRequestModel value, $Res Function(SignInRequestModel) then) =
      _$SignInRequestModelCopyWithImpl<$Res, SignInRequestModel>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class _$SignInRequestModelCopyWithImpl<$Res, $Val extends SignInRequestModel>
    implements $SignInRequestModelCopyWith<$Res> {
  _$SignInRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignInRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignInRequestModelImplCopyWith<$Res>
    implements $SignInRequestModelCopyWith<$Res> {
  factory _$$SignInRequestModelImplCopyWith(_$SignInRequestModelImpl value,
          $Res Function(_$SignInRequestModelImpl) then) =
      __$$SignInRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$SignInRequestModelImplCopyWithImpl<$Res>
    extends _$SignInRequestModelCopyWithImpl<$Res, _$SignInRequestModelImpl>
    implements _$$SignInRequestModelImplCopyWith<$Res> {
  __$$SignInRequestModelImplCopyWithImpl(_$SignInRequestModelImpl _value,
      $Res Function(_$SignInRequestModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignInRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$SignInRequestModelImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SignInRequestModelImpl implements _SignInRequestModel {
  const _$SignInRequestModelImpl({required this.email, required this.password});

  factory _$SignInRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignInRequestModelImplFromJson(json);

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'SignInRequestModel(email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignInRequestModelImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  /// Create a copy of SignInRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignInRequestModelImplCopyWith<_$SignInRequestModelImpl> get copyWith =>
      __$$SignInRequestModelImplCopyWithImpl<_$SignInRequestModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SignInRequestModelImplToJson(
      this,
    );
  }
}

abstract class _SignInRequestModel implements SignInRequestModel {
  const factory _SignInRequestModel(
      {required final String email,
      required final String password}) = _$SignInRequestModelImpl;

  factory _SignInRequestModel.fromJson(Map<String, dynamic> json) =
      _$SignInRequestModelImpl.fromJson;

  @override
  String get email;
  @override
  String get password;

  /// Create a copy of SignInRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignInRequestModelImplCopyWith<_$SignInRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
