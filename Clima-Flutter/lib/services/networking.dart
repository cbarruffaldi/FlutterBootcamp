import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    http.Response res = await http.get(url);
//    http.Response res = await http.get(
//        'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&APPID=$apiKey');

    if (res.statusCode == 200) {
      String data = res.body;
      return jsonDecode(data);
    } else {
      print(res.statusCode);
    }
  }
}
