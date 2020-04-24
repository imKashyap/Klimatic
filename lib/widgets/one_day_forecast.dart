import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class OneDayForecast extends StatelessWidget {
  String day;
  String temp;
  Image image;
  OneDayForecast(this.day,this.temp,this.image);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(day,
        style: GoogleFonts.openSans(

        ),),
        Text('$temp°',
            style: GoogleFonts.openSans(

            ),),
        Container(
          width: 80.0,
          height: 80.0,
          child: image,
        )
      ],
    );
  }
}
