import 'package:agripal/values/asset_values.dart';
import 'package:agripal/values/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HourlyWeatherContainer extends StatelessWidget{

  Map<String,dynamic> hourlyData;

  HourlyWeatherContainer({required this.hourlyData});

  String weatherIcon="";

  

  @override
  Widget build(BuildContext context) {
     
     String time=TimeOfDay.fromDateTime(DateTime.parse(hourlyData["dateTime"])).format(context);
     print(hourlyData['weathercode']);

      switch(hourlyData['weathercode']){
      case 0:
      case 1: weatherIcon= int.parse(time.substring(0,2).replaceAll(":", ""))>=6?sunny:partly_cloudy_night;
              break;
      case 2: weatherIcon= int.parse(time.substring(0,2).replaceAll(":", ""))>=6? partly_cloudy:partly_cloudy_night;
              break;
      case 3: weatherIcon=overcast;
              break;
      case 51: 
      case 53:
      case 55:
      case 61: 
      case 63: 
      case 65:
      case 80:
      case 81:
      case 82:weatherIcon=rain;
              break;
      case 95: 
      case 96:
      case 99:weatherIcon=thunderstorm;
               break;
      default: weatherIcon=sunny;
               break;
    }

      
      return Container(
         height: 80.h,
         width: 60.w,
         decoration: BoxDecoration(
            color: Colors.deepPurpleAccent.shade200,
            borderRadius: BorderRadius.circular(20),
            // boxShadow: const [
            //   BoxShadow(
            //     color: Colors.black26,
            //     blurRadius: 1,
            //     spreadRadius: 1,
                
            //   )
            // ],
          ),
         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(time.substring(0,2).replaceAll(":", "")+time.substring(time.length-2).toLowerCase(),style: font3,),
            SizedBox(height: 5.h,),
            Image.asset(weatherIcon,height: 30.h,width: 30.w,),
            SizedBox(height: 5.h,),
            Text("${hourlyData["temperature"]}\u00B0",style: font3,),
         ]),
      );
  }
}