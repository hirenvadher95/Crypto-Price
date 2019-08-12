import 'package:bitcoin_ticker/coin_data.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData c;
  String selectedCurrency = 'USD';
  DropdownButton<String> androidPicker() {
    List<DropdownMenuItem<String>> drpdownItem = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      drpdownItem.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: drpdownItem,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> pickedItem = [];
    for (String currency in currenciesList) {
      var temp = Text(currency);
      pickedItem.add(temp);
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      children: pickedItem,
      itemExtent: 35,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
    );
  }

  String bitcoinValueInUSD = '?';

  void getData() async {
    try {
      double data = await CoinData().getCoinData();

      setState(() {
        bitcoinValueInUSD = data.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $bitcoinValueInUSD USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isAndroid ? iosPicker() : androidPicker())
        ],
      ),
    );
  }
}
