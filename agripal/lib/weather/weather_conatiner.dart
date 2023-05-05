import 'package:agripal/values/asset_values.dart';
import 'package:agripal/weather/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../values/fonts.dart';

class WeatherContainer extends StatefulWidget{

  late String placename;
  late Weather currentWeather;
  // ignore: use_key_in_widget_constructors
  WeatherContainer({required this.placename,required this.currentWeather});

  @override
  State<WeatherContainer> createState() => _WeatherContainerState();
}

class _WeatherContainerState extends State<WeatherContainer> {


  Color nightColor=Color.fromARGB(255, 30, 3, 68);

  Color dayColor=Colors.orange.shade500;

  late String weatherIcon;

  @override
  void initState() {
        switch(widget.currentWeather.weathercode){
      case 0:
      case 1: weatherIcon=sunny;
              break;
      case 2: weatherIcon= widget.currentWeather.isDay==1? partly_cloudy:partly_cloudy_night;
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

    print(weatherIcon);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    
    

    return AnimatedContainer(
      height: MediaQuery.of(context).size.height*0.25,
      width: MediaQuery.of(context).size.width*0.9,
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        color: widget.currentWeather.isDay==1?dayColor:nightColor,
        borderRadius: BorderRadius.circular(30),
        // image: DecorationImage(
        //   image: AssetImage(backgroudImage),
          
        //   fit: BoxFit.cover,
        // ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            spreadRadius: 5,
            // offset: Offset(0.0, 2.0),
          )
        ],
      ),

      child:  Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.place,color: Colors.white,),
              Text(widget.placename ,style:font2,),
              
              SizedBox(width: 10.w,),
              Container(
                height: 20.h,
                width: 1.w,
                color: Colors.white,
              ),
              SizedBox(width: 15.w,),
              Text(DateFormat.yMMMMd().format(DateTime.parse(widget.currentWeather.dateTime)),style: font2,)
            ],
          ),
          SizedBox(height: 10.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
          width: 70.w,
          child: Image(image: AssetImage(weatherIcon),fit: BoxFit.scaleDown,)
              ),
              SizedBox(width: 10.w),
              Text(widget.currentWeather.temperature.toString()+"\u00B0" ,style:font1,),
            ],
          ),
          SizedBox(height: 20.h,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Text("Humidity : "+widget.currentWeather.humidity.toString()+"%",style:font2,),
              SizedBox(width: 10.w,),
              Text("Wind : "+widget.currentWeather.windSpeed.toString()+"km/h",style:font2,),
            ],
          
          )
        ],
      )),
    );
  }
}