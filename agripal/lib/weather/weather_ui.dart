import 'package:agripal/values/fonts.dart';
import 'package:agripal/weather/hourly_waether_container.dart';
import 'package:agripal/weather/weather_conatiner.dart';
import 'package:intl/intl.dart';
import 'package:agripal/weather/get_weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_icons/weather_icons.dart';



class WeatherHome extends StatefulWidget{
  
  double lat;
  double long;
  WeatherHome({required this.lat,required this.long});
  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {


  bool locationIsSet=false;
  Color weatherColor=Colors.blueAccent.shade700;

  var weather;

  setWeather()async{

     weather= await GetWeather.setWeather();

     if(weather!=null){
        
        setState(() {});
     }

  }

  @override
  void initState() {
    setWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


        return SafeArea(
          child: Scaffold(
        
            body: FutureBuilder(
              future: GetWeather.getCurrentWeatherByPosition(widget.lat, widget.long, false),
              builder:((context, snapshot) {

                    if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){

                        return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              
                            Padding(
                              padding: EdgeInsets.only(left: 20.w,top: 20.h),
                              child: Text("Today's Weather",style: font4,),
                            ),
                            Padding(
                              padding: EdgeInsets.all(20.w),
                              child: WeatherContainer(lat: widget.lat,long: widget.long,canNavigate: false),
                            ),
                          
                          Padding(
                            padding: EdgeInsets.only(left :25.w),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width *0.8,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ...weather['currentWeather'].hourlyWeather.map((hourlyData){
                                      
                                      return Padding(
                                        padding: EdgeInsets.all(5.w),
                                        child: HourlyWeatherContainer(hourlyData: hourlyData,),
                                      );
                                    })
                                    
                                  ],
                                ),
                              ),
                            ),
                          ),
                            
                            Padding(
                              padding: EdgeInsets.only(left: 20.w,top: 20.h),
                              child: Text("Next 6 Days Weather",style: font4,),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10.w,right: 10.w),
                                child: DataTable(
                                  dividerThickness: 0,
                                  
                                  columns: const <DataColumn>[
                                    DataColumn(
                                      label: Text(
                                        '',
                                        // style: TextStyle(fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        '',
                                        // style: TextStyle(fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Icon(WeatherIcons.thermometer)
                                    ),
                              
                                    DataColumn(
                                      label: Icon(WeatherIcons.humidity)
                                    ),
                                  ],
                                  rows: <DataRow>[
                                      ...weather['sevenDaysWeather'].sevenDaysWeather.map((weather){
                              
                                          String weatherIcon=GetWeather.getWeatherIcon(weather.weathercode,"10am");
                                          return DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text(DateFormat('EEEE').format(DateTime.parse(weather.dateTime)))),
                                              DataCell(Image.asset(weatherIcon,height: 30.h,width: 30.w,),),
                                              DataCell(Text(weather.temperature.toString()+"\u00B0")),
                                              DataCell(Text(weather.humidity.toString()+"%")),
                                            ],
                                          );
                                      })
                                  
                                  ],
                                )
                              )
                            
                        
                              ],
                            ),
                      );
                    }else{
                      return Center(child: CircularProgressIndicator());
                    }

              }) 
            ),
          ),
        );
        
  }



}