import 'package:agripal/values/asset_values.dart';
import 'package:agripal/values/fonts.dart';
import 'package:agripal/weather/weather_conatiner.dart';
import 'package:agripal/weather/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../common_widgets/common_widgets.dart';
import '../datamanage/datamanage.dart';

class WeatherListUI extends StatefulWidget {
  List<Weather> weatherList;

  WeatherListUI({required this.weatherList});

  @override
  State<WeatherListUI> createState() => _WeatherListUIState();
}

class _WeatherListUIState extends State<WeatherListUI> {

  void deleteItem(int index) async{

    dialogBox(context, delete, true);

    var result= await DataManage.deleteWeatherLocation(index);

    await Future.delayed(Duration(seconds: 1),(){

        Navigator.pop(context);
    });

    if(result=="ok"){
      
      setState(() {
           widget.weatherList.removeAt(index);
      });
      
      dialogBox(context, done, false);

      await Future.delayed(Duration(seconds: 3),(){
          Navigator.pop(context);

          if(widget.weatherList.isEmpty){
            Navigator.pop(context);
          }
      });

        

    }else{
      ScaffoldMessenger.of(context).hideCurrentSnackBar(); 
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error deleting location")));
    }

   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Weather Forecast",style: font4,),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
  ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.w,top: 20.h),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width*0.9,
          child: ListView.builder(
            itemCount: widget.weatherList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:  EdgeInsets.only(bottom: 8.h),
                child: Slidable(
                  endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      // An action can be bigger than the others.
                      // flex: 1,
                      onPressed:(context)=>confirmDialog(context, "Delete Location?", ()=>deleteItem(index)),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                    
                  ],
                ),

                  child: WeatherContainer(currentWeather: widget.weatherList[index], canNavigate: true,)),
              );
            },
           
          ),
        ),
      ),
    );
  }
}