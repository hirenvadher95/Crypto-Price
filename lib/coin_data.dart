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
  Future getCoinData() async {
    String requestUrl = '$bitcoinAverageURL/BTCUSD';
    http.Response response = await http.get(requestUrl);
    if (response.statusCode == 200) {
      var decodeData = jsonDecode(response.body);
      var lastPrice = decodeData['last'];
      return lastPrice;
    } else {
      throw 'Problem with Request';
    }
  }
}
