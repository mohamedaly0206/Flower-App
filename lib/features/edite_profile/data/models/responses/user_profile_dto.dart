import 'package:flower_app/features/edite_profile/domain/entities/user_profile_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile_dto.g.dart';

@JsonSerializable()
class UserDto {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'firstName')
  final String? firstName;

  @JsonKey(name: 'lastName')
  final String? lastName;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'gender')
  final String? gender;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'photo')
  final String? photo;

  @JsonKey(name: 'addresses')
  final List<dynamic>? addresses;

  UserDto({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.addresses,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: gender,
      phone: phone,
      photo: photo,
      addresses: addresses,
    );
  }
}

@JsonSerializable()
class UserProfileDto {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'user')
  final UserDto? user;

  UserProfileDto({this.message, this.user});

  factory UserProfileDto.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileDtoToJson(this);

  UserProfileEntity toEntity() {
    return UserProfileEntity(message: message, user: user?.toEntity());
  }
}
