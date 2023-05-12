import 'dart:convert';

import 'package:agripal/datamanage/datamanage.dart';
import 'package:agripal/weather/weather_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../values/asset_values.dart';
import 'get_location.dart';

class GetWeather{

  //Function to get current weather by position
  static getCurrentWeatherByPosition(double lat,double long,bool getFullData) async{

        String url="https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$long&current_weather=true&hourly=temperature_2m,relativehumidity_2m,windspeed_10m,is_day,weathercode";
    
        try{
          
          List<Placemark> placemarks = await placemarkFromCoordinates(lat,long);

          var response= await http.get(Uri.parse(url)).timeout(Duration(seconds: 30),onTimeout: (){
            return http.Response("Error",500);
          });


          if(response.statusCode!=200){
             return null;
          }
          
          var data=jsonDecode(response.body);


          String dateTime=data["current_weather"]["time"].toString().replaceFirst("T"," ")+":00";
          
          double temperature=data["current_weather"]["temperature"];
          
          int humidity=data["hourly"]["relativehumidity_2m"][0];
          
          double windSpeed=data["current_weather"]["windspeed"];
          
          int weathercode=data["current_weather"]["weathercode"];
          
          
          
          List<Map<String,dynamic>> hourlyWeather=[];

          int isDayIndex=0;
          bool found=false;

          int i=0;
          for(i=0; i<data["hourly"]["time"].length && data["hourly"]["time"][i].toString().startsWith(dateTime.split(" ")[0]) ;i++){
            hourlyWeather.add(
              {
                "dateTime": data["hourly"]["time"][i].toString().replaceFirst("T"," ")+":00",
                "temperature": data["hourly"]["temperature_2m"][i],
                "humidity": data["hourly"]["relativehumidity_2m"][i],
                "windSpeed": data["hourly"]["windspeed_10m"][i],
                "weathercode": data["hourly"]["weathercode"][i],
                "isDay": data["hourly"]["is_day"][i],
              }
            );

            String tempTime=data["hourly"]["time"][i].toString().replaceFirst("T"," ")+":00";
            
            if(!found && DateTime.parse(dateTime).isBefore(DateTime.parse(tempTime)) ){
              
              isDayIndex=i;
              found=true;
            }
            
          }

          if(!found){
            isDayIndex=hourlyWeather.length-1;
          }

          int isDay=data["hourly"]["is_day"][isDayIndex];

          Weather currentWeather=Weather(dateTime:dateTime , temperature: temperature, humidity: humidity, windSpeed: windSpeed, weathercode: weathercode);
          
          
          currentWeather.isDay=isDay;
          currentWeather.lat=lat;
          currentWeather.long=long;
          currentWeather.placename=placemarks[0].locality!;
          //return if only current weather is needed - for carosel  slider elements
          if(!getFullData){
                
              return currentWeather;
          }
          

          currentWeather.hourlyWeather=hourlyWeather;
         
          
          //Finding the weather of next seven days
          Map<String,dynamic> tempHourlyWeather;

          String tempTime = data["hourly"]["time"][i].toString().replaceFirst("T"," ")+":00";

          double avgTemp=0;
          double avgHumidity=0;
          double avgWindSpeed=0;
          String tempDateTime="";
          Map<String,int> avgWeatherCode={};
          
          List<Weather> futureDaysWeatherList=[];

          for(int count=0;i<data["hourly"]["time"].length;i++,count++){

              avgTemp+=data["hourly"]["temperature_2m"][i];
              avgHumidity+=data["hourly"]["relativehumidity_2m"][i];
              avgWindSpeed+=data["hourly"]["windspeed_10m"][i];

              if(avgWeatherCode[data["hourly"]["weathercode"][i].toString()]==null){

                avgWeatherCode[data["hourly"]["weathercode"][i].toString()]=1;

              }else{

                if(avgWeatherCode[data["hourly"]["weathercode"][i].toString()]!=null)
                  avgWeatherCode[data["hourly"]["weathercode"][i].toString()]=avgWeatherCode[data["hourly"]["weathercode"][i].toString()]!+1;

              }

              if(count == 23){
                
                avgTemp=avgTemp/24;
                avgHumidity=avgHumidity/24;
                avgWindSpeed=avgWindSpeed/24;

                int max=0;
                String maxWeatherCode="";
                for(String key in avgWeatherCode.keys){
                  if(avgWeatherCode[key]!>max){
                    max=avgWeatherCode[key]!;
                    maxWeatherCode=key;
                  }

                  tempDateTime=data["hourly"]["time"][i].toString().replaceFirst("T"," ")+":00";
                }


                Weather futureDaysWeather=Weather(temperature: avgTemp.roundToDouble(), humidity: avgHumidity.toInt(), windSpeed: avgWindSpeed.roundToDouble(), weathercode: int.parse(maxWeatherCode), dateTime: tempDateTime);
                futureDaysWeatherList.add(futureDaysWeather);

                avgTemp=0;
                avgHumidity=0;
                avgWindSpeed=0;
                avgWeatherCode={};
                count=0;
              }
              
          }

          


          SevenDaysWeather sevenDaysWeather=SevenDaysWeather(sevenDaysWeather: futureDaysWeatherList);
          

          
          return {
            "currentWeather":currentWeather,
            "sevenDaysWeather":sevenDaysWeather,
          };

        }catch(e){
          
          return null;
        }
       
  }

  //Function to get weather icon
  static getWeatherIcon(int weathercode, String time){
    
    String weatherIcon;

    int hour=int.parse(time.substring(0,time.length-2));
    bool isDayIcon=(time.endsWith("am") && hour>5 && hour!=12) || (time.endsWith("pm")) && (hour<6 || hour==12) ? true:false;

    // print("time:$time isDayIcon :$isDayIcon weathercode:$weathercode");
    switch(weathercode){
      case 0:
      case 1: weatherIcon= isDayIcon?sunny:partly_cloudy_night;
              break;
      case 2: weatherIcon= isDayIcon? partly_cloudy:partly_cloudy_night;
              break;
      case 3: weatherIcon=overcast;
              break;
      case 45:
      case 48:
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
    return weatherIcon;

  }

//Function to set weather
static setWeatherLocation() async{
    

      Position position = await  GetLocation.determinePosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude,position.longitude);
      var result= await DataManage.updateWeatherLocation({'lat':position.latitude,'long': position.longitude,'placename':placemarks[0].locality});

      
      return result;

    
}
  //for carousel slider
  static getWeatherFromList(List postionList)async{

    List<Weather> weatherList=[];

    for(int i=0;i<postionList.length;i++){

      Weather tempWeather= await GetWeather.getCurrentWeatherByPosition(postionList[i]['lat'], postionList[i]['long'], false);
      weatherList.add(tempWeather);
    }
      

    return weatherList;
  }

}