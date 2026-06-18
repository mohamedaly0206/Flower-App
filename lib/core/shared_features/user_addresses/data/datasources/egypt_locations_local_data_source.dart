import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flower_app/core/shared_features/user_addresses/data/models/local/city_model.dart';
import 'package:flower_app/core/shared_features/user_addresses/data/models/local/governorate_model.dart';

/// Loads Egyptian governorates and cities from bundled JSON assets.
/// Governorates table lives in assets/cities.json; cities table in assets/states.json.
class EgyptLocationsLocalDataSource {
  static const String governoratesAsset = 'assets/cities.json';
  static const String citiesAsset = 'assets/states.json';

  Future<List<GovernorateModel>> loadGovernorates() async {
    final jsonString = await rootBundle.loadString(governoratesAsset);
    final rows = _extractTableData(jsonString, 'governorates');
    return rows.map(GovernorateModel.fromJson).toList();
  }

  Future<List<CityModel>> loadCities() async {
    final jsonString = await rootBundle.loadString(citiesAsset);
    final rows = _extractTableData(jsonString, 'cities');
    return rows.map(CityModel.fromJson).toList();
  }

  List<CityModel> filterCitiesByGovernorate(
    List<CityModel> cities,
    String governorateId,
  ) {
    return cities.where((city) => city.governorateId == governorateId).toList();
  }

  List<Map<String, dynamic>> _extractTableData(
    String jsonString,
    String tableName,
  ) {
    final decoded = jsonDecode(jsonString) as List<dynamic>;
    for (final item in decoded) {
      if (item is Map<String, dynamic> &&
          item['type'] == 'table' &&
          item['name'] == tableName) {
        final data = item['data'] as List<dynamic>? ?? [];
        return data.cast<Map<String, dynamic>>();
      }
    }
    return [];
  }
}
