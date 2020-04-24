import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class WeatherModel {
  String cityName;
  String temp;
  String mainCondition;
  String maxTemp, minTemp;
  String windSpeed;
  String humidity;
  String pressure;
  int condition;
  String country;
  String pop;
  String icon;
  List daysForecast;
  int ts;

  WeatherModel(
      {this.cityName,
      this.temp,
      this.mainCondition,
      this.maxTemp,
      this.minTemp,
      this.windSpeed,
      this.pressure,
      this.condition,
      this.country,
        this.ts,
      this.pop,
      this.icon,
      this.daysForecast,
      this.humidity});

  WeatherModel.fromJson(Map<String, dynamic> parsedWeatherData)
      : cityName = parsedWeatherData['city_name'],
  ts=parsedWeatherData['data'][0]['ts'],
        temp = (parsedWeatherData['data'][0]['temp']).toStringAsFixed(0),
        maxTemp = (parsedWeatherData['data'][0]['max_temp']).toStringAsFixed(0),
        minTemp = (parsedWeatherData['data'][0]['low_temp']).toStringAsFixed(0),
        icon = parsedWeatherData['data'][0]['weather']['icon'],
        mainCondition = parsedWeatherData['data'][0]['weather']['description'],
        windSpeed =
            (parsedWeatherData['data'][0]['wind_spd']).toStringAsFixed(1),
        humidity = (parsedWeatherData['data'][0]['rh']).toString(),
        condition = parsedWeatherData['data'][0]['weather']['code'],
        country = parsedWeatherData['country_code'],
        pop = parsedWeatherData['data'][0]['pop'].toString(),
        daysForecast = parsedWeatherData['data'],
        pressure = (parsedWeatherData['data'][0]['pres'] * 0.000986923)
            .toStringAsFixed(0);

  Image getWeatherIcon( String icon){
    return Image.network('https://www.weatherbit.io/static/img/icons/$icon.png');
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s icecream time';
    } else if (temp > 20) {
      return 'Time for shorts and t-shirts';
    } else if (temp < 10) {
      return 'You\'ll need muffler and gloves';
    } else {
      return 'Bring a coat just in case';
    }
  }

  String getFormattedDate() {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        ts* 1000);
    var formatter = new DateFormat('yMMMMEEEEd');
    String formatted = formatter.format(dateTime);
    return formatted;
  }
}
