import 'package:flower_app/core/shared_features/user_addresses/domain/entities/user_addresses_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_addresses_dto.g.dart';

@JsonSerializable()
class AddressDto {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'street')
  final String? street;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'city')
  final String? city;

  @JsonKey(name: 'lat')
  final String? lat;

  @JsonKey(name: 'long')
  final String? long;

  @JsonKey(name: 'username')
  final String? username;

  AddressDto({
    this.id,
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
  });

  factory AddressDto.fromJson(Map<String, dynamic> json) =>
      _$AddressDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDtoToJson(this);

  AddressEntity toEntity() {
    return AddressEntity(
      id: id,
      street: street,
      phone: phone,
      city: city,
      lat: lat,
      long: long,
      username: username,
    );
  }
}

@JsonSerializable()
class UserAddressesDto {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'addresses')
  final List<AddressDto>? addresses;

  UserAddressesDto({this.message, this.addresses});

  factory UserAddressesDto.fromJson(Map<String, dynamic> json) =>
      _$UserAddressesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserAddressesDtoToJson(this);

  UserAddressesEntity toEntity() {
    return UserAddressesEntity(
      message: message,
      addresses: addresses?.map((e) => e.toEntity()).toList(),
    );
  }
}
