import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  final String url = 'https://apiv2.bitcoinaverage.com/indices/global/ticker/';

  Future getCoinData(String currency) async {
    Map<String, String> prices = {};

    for (String cryp in cryptoList) {
      String req = url + cryp + currency;
      http.Response res = await http.get(req);
      if (res.statusCode == 200) {
        String data = res.body;
        var decode = jsonDecode(data);
        String p = decode['last'].toString();
        prices[cryp] = p;
      } else {
        print(res.body);
        prices[cryp] = '?';
      }
    }

    return prices;
  }
}
