import 'package:agripal/values/asset_values.dart';
import 'package:agripal/values/fonts.dart';
import 'package:agripal/weather/get_weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HourlyWeatherContainer extends StatelessWidget{

  Map<String,dynamic> hourlyData;

  HourlyWeatherContainer({required this.hourlyData});

  String weatherIcon=sunny;

  

  @override
  Widget build(BuildContext context) {
     
     String time=TimeOfDay.fromDateTime(DateTime.parse(hourlyData["dateTime"])).format(context);
     time=time.substring(0,2).replaceAll(":", "")+time.substring(time.length-2).toLowerCase();

    weatherIcon=GetWeather.getWeatherIcon(hourlyData['weathercode'], time);

      return Container(
         height: 80.h,
         width: 60.w,
         decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                spreadRadius: 1,
                
              )
            ],
          ),
         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(time,style: font3,),
            SizedBox(height: 5.h,),
            Image.asset(weatherIcon,height: 30.h,width: 30.w,),
            SizedBox(height: 5.h,),
            Text("${hourlyData["temperature"]}\u00B0",style: font3,),
         ]),
      );
  }
}