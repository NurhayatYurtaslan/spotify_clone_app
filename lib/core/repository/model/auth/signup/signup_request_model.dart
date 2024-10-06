// To parse this JSON data, do
//
//     final signUpRequestModel = signUpRequestModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'signup_request_model.freezed.dart';
part 'signup_request_model.g.dart';

SignUpRequestModel signUpRequestModelFromJson(String str) => SignUpRequestModel.fromJson(json.decode(str));

String signUpRequestModelToJson(SignUpRequestModel data) => json.encode(data.toJson());

@freezed
class SignUpRequestModel with _$SignUpRequestModel {
    const factory SignUpRequestModel({
        required String name,
        required String email,
        required String password,
    }) = _SignUpRequestModel;

    factory SignUpRequestModel.fromJson(Map<String, dynamic> json) => _$SignUpRequestModelFromJson(json);
}