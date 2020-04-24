import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klimatic/models/weather_model.dart';
import 'package:klimatic/services/get_weather_data.dart';
import 'package:klimatic/widgets/bottom_scrollview.dart';

class LocationScreen extends StatefulWidget {
  final WeatherModel locationWeather;

  LocationScreen({@required this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel model;
  String cityName;
  String temp;
  String mainCondition;
  String maxTemp, minTemp;
  String windSpeed;
  String humidity;
  String pressure;
  String weatherMessage;
  int condition;
  Image weatherIcon;
  String country;
  String formattedDate;
  String formattedTime;
  String pop;
  String icon;
  String date;

  @override
  void initState() {
    super.initState();
    updateUi(widget.locationWeather);
  }

  void updateUi(WeatherModel weatherModel) {
    setState(() {
      try {
        model=weatherModel;
        pop = weatherModel.pop;
        date = weatherModel.getFormattedDate();
        temp = weatherModel.temp;
        maxTemp = weatherModel.maxTemp;
        minTemp = weatherModel.minTemp;
        humidity = weatherModel.humidity;
        pressure = weatherModel.pressure;
        icon=weatherModel.icon;
        mainCondition = weatherModel.mainCondition;
        windSpeed = weatherModel.windSpeed;
        condition = weatherModel.condition;
        weatherIcon = weatherModel.getWeatherIcon(icon);
        cityName = weatherModel.cityName;
        country = weatherModel.country;
        weatherMessage = weatherModel.getMessage(int.parse(temp));
      } catch (e) {
        print(e);
      }
    });
  }

  double height, width;
  String searchedCity;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF0C1230),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.03,),
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.03,
                  vertical: height * 0.01,
                ),
                alignment: Alignment.center,
                child: Text(
                  'KLIMATIC',
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: width * 0.05),
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 3.0),
                    width: width * 0.77,
                    height: height * 0.07,
                    child: TextField(
                      onChanged: (value){
                        searchedCity=value;
                      },
                      onSubmitted: (searchedCity)async{
                        if(searchedCity.isNotEmpty) {
                          WeatherModel _model = WeatherModel.fromJson(
                              await GetWeatherData(true, searchedCity)
                                  .getLocationData());
                          updateUi(_model);
                        }
                      },
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: width * 0.04,
                      ),
                      decoration: InputDecoration(
                          labelText: 'Enter city name',
                          labelStyle: GoogleFonts.openSans(
                            color: Colors.grey,
                            fontSize: width * 0.05,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xFF4E6CA3),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(width * 0.03)),
                              borderSide: BorderSide(color: Color(0xFF4E6CA3))),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF4E6CA3)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(width * 0.03)),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  Material(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    elevation: 5.0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF221177),
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: IconButton(
                        icon: Icon(
                          Icons.my_location,
                          color: Colors.grey,
                        ),
                        onPressed: () async{
                            WeatherModel model=WeatherModel.fromJson(await GetWeatherData(false).getLocationData());
                            updateUi(model);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    size: width * 0.04,
                  ),
                  Text(
                    '  $cityName, $country',
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontSize: width * 0.04,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  '$date',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: width * 0.04,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        ' $temp°',
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: height * 0.08,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '$minTemp° | $maxTemp°',
                        style: GoogleFonts.openSans(
                          color: Colors.grey,
                          fontSize: height * 0.025,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20.0,
                    height: height * 0.15,
                    child: VerticalDivider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    child: weatherIcon,
                  )
//                  Image(),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Center(
                child: Text(
                  '$mainCondition.',
                  style: GoogleFonts.openSans(
                    color: Color(0xFF4E6CA3),
                    fontSize: height * 0.02,
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.9,
                height: 20.0,
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      infoBox('Pressure:', '$pressure atm'),
                      SizedBox(
                        height: height*0.03,
                      ),
                      infoBox('Wind:', '$windSpeed km/hr'),
                    ],
                  ),
                  SizedBox(
                    width: width * 0.2,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      infoBox('Humidity:', '$humidity%'),
                      SizedBox(
                        height: height*0.03,
                      ),
                      infoBox('Precipitation:', '$pop%'),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: height*0.01,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  '$weatherMessage.',
                  style: GoogleFonts.openSans(
                    color: Color(0xFF4E6CA3),
                    fontSize: width * 0.04,
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.9,
                height: 20.0,
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              BottomScrollView(model)
            ],
          ),
        ),
      ),
    );
  }

  Widget infoBox(String title, String info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: height * 0.02,
              color: Colors.grey,
            ),
          ),
        ),
        Text(
          info,
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: height * 0.04,
            ),
          ),
        ),
      ],
    );
  }
}
