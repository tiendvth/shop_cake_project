
class ReadFile {
  static String readFile(String path) {
    const String url = 'http://103.187.5.254:8090/api/files/files/';
    return url + path;
  }
}

class DiscountCake {
  static double discountCake(double discount, double price) {
    double total = 0.0;
    double discountcacke = 0.0;
    if (discount != null){
      discountcacke = discount;
      total = price - ((price * discountcacke)/100);
    }else {

      total = 0.0;
    }
    return total;
  }
}
