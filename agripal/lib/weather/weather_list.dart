import 'package:agripal/values/fonts.dart';
import 'package:agripal/weather/weather_conatiner.dart';
import 'package:agripal/weather/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherListUI extends StatefulWidget {
  final List<Weather> weatherList;

  WeatherListUI({required this.weatherList});

  @override
  State<WeatherListUI> createState() => _WeatherListUIState();
}

class _WeatherListUIState extends State<WeatherListUI> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Weather Forecast",style: font4,),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
  ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.w,top: 20.h),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width*0.9,
          child: ListView.builder(
            itemCount: widget.weatherList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:  EdgeInsets.only(bottom: 8.h),
                child: WeatherContainer(currentWeather: widget.weatherList[index], canNavigate: true),
              );
            },
           
          ),
        ),
      ),
    );
  }
}