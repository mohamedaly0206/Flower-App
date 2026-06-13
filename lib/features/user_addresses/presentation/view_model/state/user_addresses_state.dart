import 'package:equatable/equatable.dart';
import 'package:flower_app/features/user_addresses/domain/entities/user_addresses_entity.dart';

enum UserAddressesStatus { initial, loading, success, error, deleting }

class UserAddressesState extends Equatable {
  final UserAddressesStatus status;
  final List<AddressEntity>? addresses;
  final String? errorMessage;

  const UserAddressesState({
    this.status = UserAddressesStatus.initial,
    this.addresses,
    this.errorMessage,
  });

  UserAddressesState copyWith({
    UserAddressesStatus? status,
    List<AddressEntity>? addresses,
    String? errorMessage,
    bool clearError = false,
  }) {
    return UserAddressesState(
      status: status ?? this.status,
      addresses: addresses ?? this.addresses,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, addresses, errorMessage];
}
