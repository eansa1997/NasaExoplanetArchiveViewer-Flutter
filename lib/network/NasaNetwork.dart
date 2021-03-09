import 'package:http/http.dart';

class NasaNetwork {
  Client _client;
  NasaNetwork() {
    _client = Client();
  }

  Future<String> getQuery(String url) async {
    Response response = await _client.get(Uri.parse(url));
    checkAndThrowError(response);
    return response.body;
  }

  static void checkAndThrowError(Response response) {
    // API returns 200 even if error on parameters
    //print(response.statusCode);
    //print(response.body);
    if (response.statusCode != 200) {
      throw Exception(response.body);
    } else if (response.body.startsWith("ERROR")) {
      throw Exception(response.body);
    }
  }
}
