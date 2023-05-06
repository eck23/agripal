import 'package:agripal/weather/get_weather.dart';
import 'package:agripal/weather/weather_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../weather/weather_conatiner.dart';

class NewsAndWeatherHome extends StatefulWidget {
  @override
  _NewsAndWeatherHomeState createState() => _NewsAndWeatherHomeState();
}

class _NewsAndWeatherHomeState extends State<NewsAndWeatherHome> {

   bool locationIsSet=false;

  Color weatherColor=Colors.blueAccent.shade700;
  String backgroudImage="assets/images/night.jpg";
  List carouselElemets=[];

  
  setWeather()async{

      var result= await GetWeather.setWeather();

      
      if(result!=null){
        
        setState(() {
          locationIsSet=true;
          carouselElemets.clear();
          carouselElemets.add(WeatherContainer(currentWeather: currentWeather, placename: placename, canNavigate: true,));
          // carouselElemets.addAll(sevenDaysWeather.sevenDaysWeather.map((weather) => WeatherContainer(placename: placename, currentWeather: weather,)));

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
            Padding(
              padding: EdgeInsets.only(top: 20.h,bottom: 10.h),
              child: CarouselSlider(items: carouselElemets.map((items){
                    return Builder(builder: (BuildContext){
                      return items;
                      
                      });
                }).toList(),
                
                options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.85,
                aspectRatio: 2.0,
                initialPage: 1,
              ),
                      ),
            ),
            
            
            SizedBox(height: 5.h,),
            ],
          ),
        ):Center(child: TextButton(child: Text("Set location"),onPressed: (() =>setWeather()),));
  }
}