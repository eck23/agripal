import 'dart:convert';

import 'package:agripal/weather/weather_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class GetWeather{


  static getCurrentWeatherByPosition(Position position) async{

        String url="https://api.open-meteo.com/v1/forecast?latitude=${position.latitude}&longitude=${position.longitude}&current_weather=true&hourly=temperature_2m,relativehumidity_2m,windspeed_10m,is_day,weathercode";
    
        try{
          var response= await http.get(Uri.parse(url));

          // print(response.body);

          if(response.statusCode!=200){
             return null;
          }
          
          var data=jsonDecode(response.body);

          // print(data["hourly"]["relativehumidity"]);

          // for(String name in  data["hourly"].keys){
          //   print(name);
          // }
          // print(data["current_weather"]["temperature"]);
          // for(String time in data["hourly"]["time"]){
          //   print(time+"\n");
          // }

          // print(data["hourly"]["weathercode"]);

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

          Weather weather= Weather(dateTime:dateTime , temperature: temperature, humidity: humidity, windSpeed: windSpeed, weathercode: weathercode);
          weather.isDay=isDay;
          weather.hourlyWeather=hourlyWeather;

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

          sevenDaysWeather=SevenDaysWeather(sevenDaysWeather: futureDaysWeatherList);
          

          
          return weather;

        }catch(e){
          
          return null;
        }
       
  }


}