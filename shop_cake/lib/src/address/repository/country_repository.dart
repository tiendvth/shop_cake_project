
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shop_cake/src/address/model/viet_nam_model.dart';

class CountryRepository {
  Future<List<VietNamModel>> loadLocationData() async {
    try {
      final jsonString = await rootBundle.loadString('/Users/tiendangvan/StudioProjects/shop_cake_project/shop_cake/assets/vietnam-provinces.json');
      List<Map<String, dynamic>> temp = List<Map<String, dynamic>>.from(json.decode(jsonString));
      List<Map<String, dynamic>> data = temp.toList();
      return data.map((e) => VietNamModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Error loading location data');
    }
  }

}