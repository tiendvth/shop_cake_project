class PriceFilter {
  String? message;
  List<FilterPrice>? data;

  PriceFilter({this.message, this.data});

  PriceFilter.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <FilterPrice>[];
      json['data'].forEach((v) {
        data!.add(new FilterPrice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FilterPrice {
  int? priceFrom;
  int? priceTo;

  FilterPrice({this.priceFrom, this.priceTo});

  FilterPrice.fromJson(Map<String, dynamic> json) {
    priceFrom = json['price_from'];
    priceTo = json['price_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price_from'] = this.priceFrom;
    data['price_to'] = this.priceTo;
    return data;
  }
}