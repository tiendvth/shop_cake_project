
class ReadFile {
  static String readFile(String path) {
    const String url = 'http://103.187.5.254:8090/api/files/files/';
    return url + path;
  }
}
