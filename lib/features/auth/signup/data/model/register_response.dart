import 'package:json_annotation/json_annotation.dart';

import '../../domain/model/register_details.dart';
import '../../domain/model/user_entity.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "code")
  final String? code;

  @JsonKey(name: "token")
  final String? token;

  @JsonKey(name: "user")
  final UserResponse? user;

  RegisterResponse({this.message, this.code, this.token, this.user});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);

  RegisterDetails toDomain() {
    return RegisterDetails(
      message: message ?? "",
      token: token ?? "",
      user:
          user?.toEntity() ??
          const UserEntity(
            id: "",
            firstName: "",
            lastName: "",
            email: "",
            phone: "",
            role: "",
            isVerified: false,
            createdAt: "",
            gender: "",
          ),
    );
  }
}

@JsonSerializable()
class UserResponse {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "firstName")
  final String? firstName;

  @JsonKey(name: "lastName")
  final String? lastName;

  @JsonKey(name: "email")
  final String? email;

  @JsonKey(name: "phone")
  final String? phone;

  @JsonKey(name: "gender")
  final String? gender;

  @JsonKey(name: "role")
  final String? role;

  @JsonKey(name: "isVerified")
  final bool? isVerified;

  @JsonKey(name: "createdAt")
  final String? createdAt;

  UserResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.role,
    this.isVerified,
    this.createdAt,
    this.gender,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  UserEntity toEntity() {
    return UserEntity(
      id: id ?? "",
      firstName: firstName ?? "",
      lastName: lastName ?? "",
      email: email ?? "",
      phone: phone ?? "",
      gender: gender ?? "",
      role: role ?? "",
      isVerified: isVerified ?? false,
      createdAt: createdAt ?? "",
    );
  }
}
