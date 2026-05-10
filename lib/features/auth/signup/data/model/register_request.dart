import 'package:json_annotation/json_annotation.dart';
import '../../domain/model/register_params.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "password")
  final String? password;
  @JsonKey(name: "rePassword")
  final String? rePassword;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "gender")
  final String? gender;

  RegisterRequest({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.rePassword,
    this.phone,
    this.gender,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return _$RegisterRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RegisterRequestToJson(this);
  }

  factory RegisterRequest.fromParams(RegisterParams params) {
    return RegisterRequest(
      firstName: params.firstName,
      lastName: params.lastName,
      email: params.email,
      password: params.password,
      rePassword: params.rePassword,
      phone: params.phone,
      gender: params.gender,
    );
  }
}
