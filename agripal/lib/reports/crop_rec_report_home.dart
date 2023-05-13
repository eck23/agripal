import 'package:agripal/values/fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_icons/weather_icons.dart';

import '../datamanage/datamanage.dart';
import '../values/asset_values.dart';

class CropRecommendReportHome extends StatefulWidget {
  @override
  _CropRecommendReportHomeState createState() => _CropRecommendReportHomeState();
}

class _CropRecommendReportHomeState extends State<CropRecommendReportHome>{

  var stream=DataManage.ref.snapshots();

  List colorList=[
    Color.fromARGB(255, 4, 75, 133),Color.fromARGB(255, 209, 29, 29),
     Color.fromARGB(255, 4, 155, 84),
     Color.fromARGB(255, 235, 161, 23)
     ];

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), 
        backgroundColor: Colors.amber,
        title: Text("Crop Recommendation Report",style: font7,),
      ),
      body: StreamBuilder(
        stream: stream,
        builder: (context,AsyncSnapshot<DocumentSnapshot<Map<String,dynamic>>> snapshot) {
          if(snapshot.hasData){
            
            if(snapshot.data!['savedCropRecommendations'].isEmpty){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(empty,height: 200.h,width: 200.w,repeat: false,),
                    Text("No Reports",style: font3,)
                  ],
                ),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!['savedCropRecommendations'].length,
              itemBuilder: (context, index){

                var item=snapshot.data!['savedCropRecommendations'][index];
                return Container(
                  height: 150.h,
                  width: MediaQuery.of(context).size.width*0.5,
                  margin: EdgeInsets.symmetric(vertical: 15.h,horizontal: 20.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: colorList[index%colorList.length],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ]
                  ),

                  child: Stack(
                    fit: StackFit.expand,
                    children: [

                        Container(
                          height: 50.h,
                          width: double.infinity,
                          child: Opacity(
                            opacity: 0.2,
                            child: Lottie.asset("assets/lottie/grass.json",fit: BoxFit.fill,))),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 15.h,),
                              Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(item['crop'],style: font8,),
                                SizedBox(width: 10.w,),
                                Container(height: 20.h,width: 1.w,color: Colors.white),
                                SizedBox(width: 10.w,),
                                Text(DateFormat.yMMMMd().format(DateTime.parse(item['time'])),style: font8,),

                              ],
                            ),

                            SizedBox(height: 2.h,), 
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                    dividerThickness: 0,
                                    columnSpacing: 18.w,
                                    columns: <DataColumn>[
                                      DataColumn(
                                        label: Text(
                                          'N',
                                          style: font10,
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'P',
                                          style: font10,
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'K',
                                          style: font10,
                                        ),
                                      ),
                            
                                      DataColumn(
                                        label: Text(
                                          'pH',
                                          style: font10,
                                        ),
                                      ),
                            
                                      DataColumn(
                                        label: Icon(WeatherIcons.thermometer,color: Colors.white,)
                                      ),
                                
                                      DataColumn(
                                        label: Icon(WeatherIcons.humidity,color: Colors.white,)
                                      ),
                            
                                       DataColumn(
                                        label: Icon(WeatherIcons.raindrop,color: Colors.white,)
                                      ),
                                    ],
                                    rows: <DataRow>[
                                       DataRow(
                                              
                                              cells: <DataCell>[
                                                DataCell(Text(item['nitrogen'].toStringAsFixed(1),style: font10,)),
                                                DataCell(Text(item['phosphorus'].toStringAsFixed(1),style: font10,)),
                                                DataCell(Text(item['potassium'].toStringAsFixed(1),style: font10,)),
                                                DataCell(Text(item['ph'].toStringAsFixed(1),style: font10,)),
                                                DataCell(Text(item['temperature'].toStringAsFixed(1),style: font10,)),
                                                DataCell(Text(item['humidity'].toStringAsFixed(1),style: font10,),),
                                                DataCell(Text(item['rainfall'].toStringAsFixed(1),style: font10, )),
                                              ],
                                            )
                                        ],
                                  ),
                            ),
                            ],
                          ),
                  ]),
                );
            });
          }else{
            if(snapshot.hasError){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(oopsie,height: 200.h,width: 200.w),
                    Text("Error",style: font3,)
                  ],
                ),
              );
            }

            return Center(
              child: Container(
                height: 100.h,
                width: 100.w,
                child: Lottie.asset(plant_loading,fit: BoxFit.contain,),
              )
            );
          }
      },)
    );
  }
  
}