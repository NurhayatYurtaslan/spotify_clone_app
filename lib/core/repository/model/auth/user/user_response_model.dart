import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_response_model.freezed.dart';
part 'user_response_model.g.dart';

UserResponseModel userResponseModelFromJson(String str) =>
    UserResponseModel.fromJson(json.decode(str));

String userResponseModelToJson(UserResponseModel data) =>
    json.encode(data.toJson());

@freezed
class UserResponseModel with _$UserResponseModel {
  const factory UserResponseModel({
    required String fullName,
    required String email,
  }) = _UserResponseModel;

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserResponseModelFromJson(json);

  factory UserResponseModel.fromDocumentSnapshot(
      DocumentSnapshot documentSnapshot) {
    final Map<String, dynamic> data =
        documentSnapshot.data() as Map<String, dynamic>;
    return UserResponseModel.fromJson(data);
  }
}