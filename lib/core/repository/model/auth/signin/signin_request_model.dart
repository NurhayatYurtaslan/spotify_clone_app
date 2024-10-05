import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'signin_request_model.freezed.dart';
part 'signin_request_model.g.dart';

SignInRequestModel signInRequestModelFromJson(String str) => SignInRequestModel.fromJson(json.decode(str));

String signInRequestModelToJson(SignInRequestModel data) => json.encode(data.toJson());

@freezed
class SignInRequestModel with _$SignInRequestModel {
    const factory SignInRequestModel({
        required String email,
        required String password,
    }) = _SignInRequestModel;

    factory SignInRequestModel.fromJson(Map<String, dynamic> json) => _$SignInRequestModelFromJson(json);
}