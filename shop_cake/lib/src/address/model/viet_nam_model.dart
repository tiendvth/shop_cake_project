class VietNamModel {
  String? name;
  List<Districts>? districts;

  VietNamModel({this.name, this.districts});

  VietNamModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['districts'] != null) {
      districts = <Districts>[];
      json['districts'].forEach((v) {
        districts!.add(new Districts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.districts != null) {
      data['districts'] = this.districts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Districts {
  String? name;
  List<Wards>? wards;

  Districts({this.name, this.wards});

  Districts.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['wards'] != null) {
      wards = <Wards>[];
      json['wards'].forEach((v) {
        wards!.add(new Wards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.wards != null) {
      data['wards'] = this.wards!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wards {
  String? name;

  Wards({this.name});

  Wards.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}