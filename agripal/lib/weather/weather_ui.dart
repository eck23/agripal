import 'package:agripal/weather/get_location.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class WeatherHome extends StatefulWidget{

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  @override
  Widget build(BuildContext context) {

      return Center(
        child: TextButton(child: Text("Get location btn"),onPressed: ()async{
            print("Hello world");
          Position position = await  GetLocation.determinePosition();
          print("Lat :${position.latitude}, Long :${position.longitude}");

        },),
      );
  }
}