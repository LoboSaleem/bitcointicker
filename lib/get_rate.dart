import 'package:http/http.dart' as http;
import 'dart:convert';

//const apiKey2 = '3F361A29-8D49-4AFA-85EE-D9394AD83948';
const apiKey = '0876C2CB-9C00-4EF0-9081-63DAE51CA7C3';

const coinapi = 'https://rest.coinapi.io/v1/exchangerate';

class NetWorkHelper {
  NetWorkHelper(this.url);

  final String url;
  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}

class WeatherModel {
  Future<dynamic> getCityWeather(
    String cY,
    String currency,
  ) async {
    String url = '$coinapi/$cY/$currency?apikey=$apiKey';
    NetWorkHelper netWorkHelper = NetWorkHelper(url);
    var currencyData = await netWorkHelper.getData();
    print(url);

    return currencyData['rate'];
  }
}
// class GetRate{
//   Future<dynamic> exchangRate(String currency){
//     String data =
//
//   }
// }

// double BTC = 19386.10;
// double ETH = 1056.33;
// double LTC = 51.32;
//
// Future<dynamic>getCityWeather(String cY,
//     String currency){
//
//   return
// }
