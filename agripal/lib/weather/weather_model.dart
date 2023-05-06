class Weather{

    late String dateTime;
    late double temperature;
    late int humidity;
    late double windSpeed; 
    late int weathercode;
    late int isDay;
    late List<Map<String,dynamic>> hourlyWeather;

    Weather({required this.dateTime,required this.temperature,required this.humidity,required this.windSpeed,required this.weathercode});

}

// class FutureDaysWeather{

//     late double temperature;
//     late double humidity;
//     late double windSpeed; 
//     late int weathercode;

//     FutureDaysWeather({required this.temperature,required this.humidity,required this.windSpeed,required this.weathercode});
// }

class SevenDaysWeather{

  late List<Weather> sevenDaysWeather;

  SevenDaysWeather({required this.sevenDaysWeather});
}

// late SevenDaysWeather sevenDaysWeather;
// late Weather currentWeather;
// String placename="";
// String country="";

