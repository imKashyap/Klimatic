import 'package:klimatic/services/location.dart';
import 'package:klimatic/services/networking.dart';

class GetWeatherData {
  bool isFromSearch;
  String city;
  GetWeatherData(this.isFromSearch,[this.city]);
  String apiKey = '6f714243f6104ce980efdd7897963a68';
  String openWeatherUrl = 'https://api.weatherbit.io/v2.0/forecast/daily';

  getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    String cityName=isFromSearch?city:location.cityName;
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherUrl?city=$cityName&key=$apiKey&days=7');
    return await networkHelper.getData();
  }
}
