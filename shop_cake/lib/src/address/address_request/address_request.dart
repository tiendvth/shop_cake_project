class AddressRequest {
  final String? name;
  final int? page;
  final int? size;
  final String? address;
  final String? phone;

  AddressRequest({
    this.name,
    this.page,
    this.size,
    this.address,
    this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'page': page,
      'size': size,
      'address': address,
      'phone': phone,
    };
  }
}
