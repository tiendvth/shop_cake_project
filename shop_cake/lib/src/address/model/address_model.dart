class Address {
  int? code;
  String? message;
  Data? data;

  Address({this.code, this.message, this.data});

  Address.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? pageSize;
  int? pageNumber;
  int? totalPages;
  int? totalItems;
  List<Result>? result;

  Data(
      {this.pageSize,
        this.pageNumber,
        this.totalPages,
        this.totalItems,
        this.result});

  Data.fromJson(Map<String, dynamic> json) {
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    totalPages = json['totalPages'];
    totalItems = json['totalItems'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageSize'] = this.pageSize;
    data['pageNumber'] = this.pageNumber;
    data['totalPages'] = this.totalPages;
    data['totalItems'] = this.totalItems;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? id;
  int? userId;
  String? address;
  String? phone;
  int? status;
  int? isDeleted;
  String? name;

  Result(
      {this.id,
        this.userId,
        this.address,
        this.phone,
        this.status,
        this.isDeleted,
        this.name});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    address = json['address'];
    phone = json['phone'];
    status = json['status'];
    isDeleted = json['isDeleted'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['status'] = this.status;
    data['isDeleted'] = this.isDeleted;
    data['name'] = this.name;
    return data;
  }
}