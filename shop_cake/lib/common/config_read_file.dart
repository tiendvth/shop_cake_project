
class ReadFile {
  static String readFile(String path) {
    const String url = 'http://103.187.5.254:8090/api/files/files/';
    return url + path;
  }
}

class DiscountCake {
  static double discountCake(double discount, double price) {
    final double discountCake;
    double total;
    if (discount != null && price != null){
      discountCake = discount;
      total = price - ((price * discountCake)/100);
    }else {
      total = 0.0;
    }
    return total;
  }
}
