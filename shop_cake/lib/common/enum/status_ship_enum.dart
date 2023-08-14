enum StatusShipEnum {
  /// chờ xác nhận
  confirm,
  /// đã xác nhận
  confirmed,
  /// Đang giao
  shipping,
  /// Đã giao
  shipped,
  /// Đã hủy
  canceled,
}
String statusShipEnumToString(StatusShipEnum statusShipEnum) {
  switch (statusShipEnum) {
    case StatusShipEnum.confirm:
      return 'Chờ xác nhận';
    case StatusShipEnum.confirmed:
      return 'Đã xác nhận';
    case StatusShipEnum.shipping:
      return 'Đang giao';
    case StatusShipEnum.shipped:
      return 'Đã giao';
    case StatusShipEnum.canceled:
      return 'Đã hủy';
    default:
      return '';
  }
}
StatusShipEnum statusShipEnumFromString(int statusShipEnum) {
  switch (statusShipEnum) {
    case 1:
      return StatusShipEnum.confirm;
    case 2:
      return StatusShipEnum.confirmed;
    case 3:
      return StatusShipEnum.shipping;
    case 4:
      return StatusShipEnum.shipped;
    case 5:
      return StatusShipEnum.canceled;
    default:
      return StatusShipEnum.confirm;
  }
}