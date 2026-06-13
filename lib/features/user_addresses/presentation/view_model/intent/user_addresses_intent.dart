import 'package:equatable/equatable.dart';
import 'package:flower_app/features/user_addresses/domain/entities/user_addresses_entity.dart';

sealed class UserAddressesIntent extends Equatable {
  const UserAddressesIntent();

  @override
  List<Object?> get props => [];
}

class FetchUserAddressesIntent extends UserAddressesIntent {
  const FetchUserAddressesIntent();
}

class DeleteAddressIntent extends UserAddressesIntent {
  final String id;

  const DeleteAddressIntent(this.id);

  @override
  List<Object?> get props => [id];
}

class NavigateToAddAddressIntent extends UserAddressesIntent {
  const NavigateToAddAddressIntent();
}

class NavigateToEditAddressIntent extends UserAddressesIntent {
  final AddressEntity address;

  const NavigateToEditAddressIntent(this.address);

  @override
  List<Object?> get props => [address];
}
