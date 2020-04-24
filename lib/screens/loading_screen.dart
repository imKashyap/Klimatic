import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:klimatic/models/weather_model.dart';
import 'package:klimatic/services/get_weather_data.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {


  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData=await GetWeatherData(false).getLocationData();
    WeatherModel weatherModel=WeatherModel.fromJson(weatherData);
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(locationWeather: weatherModel);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0C1230),
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
