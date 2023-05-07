class Weather{

    late String dateTime;
    late double temperature;
    late int humidity;
    late double windSpeed; 
    late int weathercode;
    late int isDay;
    late List<Map<String,dynamic>> hourlyWeather;
    late double lat;
    late double long;
    late String placename;

    Weather({required this.dateTime,required this.temperature,required this.humidity,required this.windSpeed,required this.weathercode});

}

class SevenDaysWeather{

  late List<Weather> sevenDaysWeather;

  SevenDaysWeather({required this.sevenDaysWeather});
}


