import 'package:agripal/values/fonts.dart';
import 'package:agripal/weather/hourly_waether_container.dart';
import 'package:agripal/weather/weather_conatiner.dart';
import 'package:intl/intl.dart';
import 'package:agripal/weather/get_weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_icons/weather_icons.dart';



class WeatherHome extends StatefulWidget{
  
  double lat;
  double long;
  WeatherHome({required this.lat,required this.long});
  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {


  @override
  void initState() {
    // setWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


        return SafeArea(
          child: Scaffold(
        
            body: FutureBuilder(
              future: GetWeather.getCurrentWeatherByPosition(widget.lat, widget.long, true),
              builder:((context, AsyncSnapshot<dynamic>snapshot) {

                    if(snapshot.hasData){

                        return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              
                            Padding(
                              padding: EdgeInsets.only(left: 20.w,top: 20.h),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.arrow_back_ios),
                                  ),
                                  Text("Today's Weather",style: font4,),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(20.w),
                              child: WeatherContainer(currentWeather: snapshot.data!['currentWeather'],canNavigate: false),
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
                                    ...snapshot.data['currentWeather'].hourlyWeather.map((hourlyData){
                                      
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
                                      ...snapshot.data['sevenDaysWeather'].sevenDaysWeather.map((weather){
                              
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
                      return Center(child: Container(
                        height: 150.h,
                        width: 100.w,
                        child: Lottie.asset("assets/lottie/weather_loading.json",fit: BoxFit.fill,)));
                    }

              }) 
            ),
          ),
        );
        
  }



}