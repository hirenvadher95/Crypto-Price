import 'package:http/http.dart' as http;
import 'dart:convert';

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
const bitcoinAverageURL =
    'https://apiv2.bitcoinaverage.com/indices/global/ticker';

class CoinData {
  Future getCoinData(String curr) async {
    Map<String, String> crypto = {};
    for (String cry in cryptoList) {
      String requestUrl = '$bitcoinAverageURL/$cry$curr';

      http.Response response = await http.get(requestUrl);
      if (response.statusCode == 200) {
        var decodeData = jsonDecode(response.body);
        var lastPrice = decodeData['last'];
        crypto[cry] = lastPrice.toStringAsFixed(0);
      } else {
        throw 'Problem with Request';
      }
    }
    return crypto;
  }
}
