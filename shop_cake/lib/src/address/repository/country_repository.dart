
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shop_cake/src/address/model/viet_nam_model.dart';

class CountryRepository {
  Future<List<Locations>> getLocations() async {
    try {
      final jsonString = await rootBundle.loadString(
          'assets/vietnam-provinces.json');
      List<Map<String, dynamic>> temp = List<Map<String, dynamic>>.from(
          json.decode(jsonString));
      List<Map<String, dynamic>> data = temp.toList();
      return data.map((e) => Locations.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Error loading location data');
    }
  }
}