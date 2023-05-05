import 'package:agripal/weather/hourly_waether_container.dart';
import 'package:agripal/weather/weather_conatiner.dart';
import 'package:agripal/weather/weather_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:agripal/weather/get_location.dart';
import 'package:agripal/weather/get_weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';



class WeatherHome extends StatefulWidget{

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {


  bool locationIsSet=false;

  String placename="";
  String country="";
  // String date="";
  // double temperature=0.0;
  // int humidity=0;
  // double windSpeed=0.0;
  // int weathercode=0;
  // int isDay=0;

  late Weather currentWeather;
  Color weatherColor=Colors.blueAccent.shade700;
  String backgroudImage="assets/images/night.jpg";




  setWeather()async{

      Position position = await  GetLocation.determinePosition();
      
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      // print("Lat :${position.latitude}, Long :${position.longitude},");
      print("place :${placemarks[0].locality}, country :${placemarks[0].country},");

      currentWeather= await GetWeather.getCurrentWeatherByPosition(position);

      
      if(currentWeather!=null){
        setState(() {
          locationIsSet=true;
          placename=placemarks[0].locality!;
          country=placemarks[0].country!;
          

        });
      }

  }

  @override
  Widget build(BuildContext context) {

      // return Center(
      //   child: TextButton(child: Text("Get location btn"),onPressed: ()async{
      //       print("Hello world");
      //     Position position = await  GetLocation.determinePosition();
      //     List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      //     // print("Lat :${position.latitude}, Long :${position.longitude},");
      //     print("Lat :${placemarks[0].locality}, Long :${placemarks[0].country},");

      //      GetWeather.getCurrentWeatherByPosition(position);

      //   },),
      // );

      //Weather forecast container
        return locationIsSet? SingleChildScrollView(
          
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20.w),
                child: WeatherContainer(currentWeather: currentWeather, placename: placename,),
              ),
             // ...sevenDaysWeather.sevenDaysWeather.map((weather) => WeatherContainer(weatherColor:weatherColor , placename: placename, currentWeather: weather,)),
            SizedBox(height: 15.h,),
             SizedBox(
              width: MediaQuery.of(context).size.width *0.8,
               child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...currentWeather.hourlyWeather.map((hourlyData){
                      
                      return Padding(
                        padding: EdgeInsets.only(left: 5.w,right: 5.w),
                        child: HourlyWeatherContainer(hourlyData: hourlyData,),
                      );
                    })
                    
                  ],
                 ),
               ),
             )
            ],
          )
          
        ):Center(child: TextButton(child: Text("Set location"),onPressed: (() =>setWeather()),));
        
  }
}