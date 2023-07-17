import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shop_cake/src/list_food/model/price_filter.dart';

abstract class PriceFilterRepository {
  Future<List<FilterPrice>?> lisPriceFilter();
}
class PriceFilterRepositoryImpl implements PriceFilterRepository {

  @override
  Future<List<FilterPrice>?> lisPriceFilter() async {
    try {
      final jsonString = await rootBundle.loadString(
          'assets/price_seclect.json');
      Map<String, dynamic> temp = json.decode(jsonString);
      List<dynamic> data = temp['data'].toList();
      return data.map((e) => FilterPrice.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Error loading location data');
    }
  }
}