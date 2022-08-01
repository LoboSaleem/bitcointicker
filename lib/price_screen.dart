import 'dart:ffi';

import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'get_rate.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String dropdownValue = 'USD';
  var data = [];
  String cuBtc = "1 BTC = USD";
  String cuEth = "1 BTC = USD";
  String cuLtc = "1 BTC = USD";
  WeatherModel weatherModel = WeatherModel();
  DropdownButton<dynamic> androidDropList() {
    List<DropdownMenuItem<dynamic>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<dynamic>(
      value: dropdownValue,
      items: dropdownItems,
      onChanged: (dynamic value) {
        setState(() {
          dropdownValue = value;

          p();
        });
      },
    );
  }

  // void initState() {
  //   super.initState();
  //   print(te);
  // }

  Future<dynamic> p() async {
    // for (String i in cryptoList)
    for (int i = 0; i < cryptoList.length; i++) {
      print('cryptoList[i]= ${cryptoList[i]}');
      var rate =
          await weatherModel.getCityWeather(cryptoList[i], dropdownValue);
      print('rate= $rate');

      data.add(rate.toStringAsFixed(2));
      print(cryptoList[i]);
    }
    setState(() {
      cuBtc = "1 ${cryptoList[0]} = ${data[0]} $dropdownValue";
      cuEth = "1 ${cryptoList[1]} = ${data[1]} $dropdownValue";
      cuLtc = "1 ${cryptoList[2]} = ${data[2]} $dropdownValue";
    });
    print('===================================================');
    print('cuBtc= $cuBtc');
    print('cuEth= $cuEth');
    print('cuLtc= $cuLtc');
  }

  CupertinoPicker iosPicker() {
    List<Text> cupertionItems = [];
    for (String currency in currenciesList) {
      cupertionItems.add(Text(currency));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: cupertionItems,
    );
  }

  // for (var i = 0; i >= obCoin.currenciesList.length; i++)
  // {
  // child: Text(obCoin.currenciesList[i]),
  // value: obCoin.currenciesList[i],),
  //
  // },
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
            child: Column(
              children: [
                RateText(rate: cuBtc),
                RateText(rate: cuEth),
                RateText(rate: cuLtc),
              ],
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isAndroid ? androidDropList() : iosPicker()),
        ],
      ),
    );
  }
}

class RateText extends StatelessWidget {
  RateText({required this.rate});

  final String rate;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          rate,
          textAlign: TextAlign.center,
          style: kText,
        ),
      ),
    );
  }
}
