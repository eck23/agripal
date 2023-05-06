import 'package:agripal/weather/weather_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../values/fonts.dart';
import 'get_weather.dart';

class WeatherContainer extends StatefulWidget{

  // late String placename;
  // late Weather currentWeather;
  late double lat;
  late double long;
  late bool canNavigate;
  // ignore: use_key_in_widget_constructors
  WeatherContainer({required this.lat,required this.long,required this.canNavigate});

  @override
  State<WeatherContainer> createState() => _WeatherContainerState();
}

class _WeatherContainerState extends State<WeatherContainer> {


  Color nightColor=Color.fromARGB(255, 30, 3, 68);

  Color dayColor=Colors.orange.shade500;

  late String weatherIcon;
  


  @override
  Widget build(BuildContext context) {
    

    return InkWell(
      
      onTap: (){
        if(widget.canNavigate){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>WeatherHome(lat: widget.lat,long: widget.long,)));
        }
      },

      child: FutureBuilder(
        future: GetWeather.getCurrentWeatherByPosition(widget.lat, widget.long, false),
        builder: ((context,AsyncSnapshot<dynamic> snapshot){
          
          if(snapshot.hasData && snapshot.connectionState==ConnectionState.done){
               String time=TimeOfDay.fromDateTime(DateTime.parse(snapshot.data!['currentWeather'].dateTime)).format(context);
              time=time.substring(0,2).replaceAll(":", "")+time.substring(time.length-2).toLowerCase();

              weatherIcon=GetWeather.getWeatherIcon(snapshot.data!['currentWeather'].weathercode, time);

              return Container(

              height: MediaQuery.of(context).size.height*0.25,
              width: MediaQuery.of(context).size.width*0.9,
              decoration: BoxDecoration(
              color: snapshot.data!['currentWeather'].isDay==1?dayColor:nightColor,
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 2,
                  spreadRadius: 2,
                  // offset: Offset(0.0, 2.0),
                )
              ],
            ),
            
            child:  Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.place,color: Colors.white,),
                    Text(snapshot.data!['placename'] ,style:font2,),
                    
                    SizedBox(width: 10.w,),
                    Container(
                      height: 20.h,
                      width: 1.w,
                      color: Colors.white,
                    ),
                    SizedBox(width: 15.w,),
                    Text(DateFormat.yMMMMd().format(DateTime.parse(snapshot.data!['currentWeather'].dateTime)),style: font2,)
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
                    Text(snapshot.data!['currentWeather'].temperature.toString()+"\u00B0" ,style:font1,),
                  ],
                ),
                SizedBox(height: 20.h,),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Text("Humidity : "+snapshot.data!['currentWeather'].humidity.toString()+"%",style:font2,),
                    SizedBox(width: 10.w,),
                    Text("Wind : "+snapshot.data!['currentWeather'].windSpeed.toString()+"km/h",style:font2,),
                  ],
                
                )
              ],
              ),
            ),
           );
          }else{
             
             return Container(
              height: MediaQuery.of(context).size.height*0.25,
              width: MediaQuery.of(context).size.width*0.9,
              decoration: BoxDecoration(
              color: dayColor,
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 2,
                  spreadRadius: 2,
                  // offset: Offset(0.0, 2.0),
                )
              ],
            ),
            child: Center(child: Container(
                        height: 150.h,
                        width: 100.w,
                        child: Lottie.asset("assets/lottie/weather_loading.json",fit: BoxFit.fill,)),)
            );
          }
          
        }),
        
      ),
    );
  }
}