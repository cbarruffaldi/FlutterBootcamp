import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';
  Map<String, String> coinValues = {};
  bool isWaiting = false;

  void getData() async {
    isWaiting = true;

    var data = await CoinData().getCoinData(selectedCurrency);
    isWaiting = false;

    setState(() {
      coinValues = data;
    });
  }

  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String s in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(s),
        value: s,
      );

      dropdownItems.add(newItem);
    }
    return DropdownButton(
        value: selectedCurrency,
        items: dropdownItems,
        onChanged: (value) {
          setState(
            () {
              selectedCurrency = value;
            },
          );
        });
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          setState(() {
            selectedCurrency = currenciesList[selectedIndex];
            getData();
          });
        },
        children: pickerItems);
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
          CryptoBox(
            'BTC',
            isWaiting ? '?' : coinValues['BTC'],
            selectedCurrency,
          ),
          CryptoBox(
            'ETH',
            isWaiting ? '?' : coinValues['ETH'],
            selectedCurrency,
          ),
          CryptoBox(
            'LTC',
            isWaiting ? '?' : coinValues['LTC'],
            selectedCurrency,
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? iOSPicker() : androidDropDown()),
        ],
      ),
    );
  }
}

class CryptoBox extends StatelessWidget {
  CryptoBox(this.selectedCryptoCurrency, this.value, this.selectedCurrency);

  final String value;
  final String selectedCryptoCurrency;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              '1 $selectedCryptoCurrency = $value $selectedCurrency',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            )),
      ),
    );
  }
}
