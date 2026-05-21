import 'package:flower_app/features/edite_profile/domain/entities/user_profile_entity.dart';

/// Builds a partial PUT body for [PUT /auth/editProfile], matching Postman behavior.
Map<String, dynamic> buildEditProfileBody({
  required UserEntity current,
  required UserEntity? baseline,
}) {
  final body = <String, dynamic>{};

  void addIfChanged(String key, String? currentValue, String? baselineValue) {
    final trimmed = currentValue?.trim();
    if (trimmed == null || trimmed.isEmpty) return;
    if (trimmed != (baselineValue?.trim() ?? '')) {
      body[key] = trimmed;
    }
  }

  addIfChanged('firstName', current.firstName, baseline?.firstName);
  addIfChanged('lastName', current.lastName, baseline?.lastName);
  addIfChanged('email', current.email, baseline?.email);
  addIfChanged('phone', current.phone, baseline?.phone);

  final gender = normalizeProfileGender(current.gender);
  final baselineGender = normalizeProfileGender(baseline?.gender);
  if (gender != null && gender != baselineGender) {
    body['gender'] = gender;
  }

  return body;
}

/// Basic email format check for edit-profile submit.
bool isValidProfileEmail(String? email) {
  final trimmed = email?.trim();
  if (trimmed == null || trimmed.isEmpty) return false;
  return RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$').hasMatch(trimmed);
}

/// API expects lowercase [male] / [female] (same as signup).
String? normalizeProfileGender(String? raw) {
  if (raw == null || raw.trim().isEmpty) return null;
  final value = raw.trim().toLowerCase();
  if (value == 'male' || value == 'female') return value;
  return null;
}

/// Ensures [UserEntity.gender] is stored as signup values: `male` / `female`.
UserEntity? userWithNormalizedGender(UserEntity? user) {
  if (user == null) return null;
  final gender = normalizeProfileGender(user.gender);
  if (gender == user.gender) return user;
  return user.copyWith(gender: gender);
}

/// Merges PUT [editProfile] response with local edits.
///
/// Fields present in [sentBody] always keep the submitted values so partial or
/// stale API [user] payloads cannot overwrite email, gender, etc.
UserEntity mergeEditProfileSuccessUser({
  required UserEntity localUser,
  required UserEntity? responseUser,
  required Map<String, dynamic> sentBody,
}) {
  final local = userWithNormalizedGender(localUser)!;
  final api = userWithNormalizedGender(responseUser);
  final base = api ?? local;

  var merged = UserEntity(
    id: base.id ?? local.id,
    firstName: base.firstName ?? local.firstName,
    lastName: base.lastName ?? local.lastName,
    email: base.email ?? local.email,
    phone: base.phone ?? local.phone,
    photo: base.photo ?? local.photo,
    gender: base.gender ?? local.gender,
    addresses: base.addresses ?? local.addresses,
  );

  if (sentBody.containsKey('firstName')) {
    merged = merged.copyWith(firstName: sentBody['firstName'] as String?);
  }
  if (sentBody.containsKey('lastName')) {
    merged = merged.copyWith(lastName: sentBody['lastName'] as String?);
  }
  if (sentBody.containsKey('email')) {
    merged = merged.copyWith(email: (sentBody['email'] as String?)?.trim());
  }
  if (sentBody.containsKey('phone')) {
    merged = merged.copyWith(phone: sentBody['phone'] as String?);
  }
  if (sentBody.containsKey('gender')) {
    final gender = normalizeProfileGender(sentBody['gender'] as String?);
    if (gender != null) {
      merged = merged.copyWith(gender: gender);
    }
  }

  return userWithNormalizedGender(merged)!;
}
