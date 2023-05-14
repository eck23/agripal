import 'dart:io';
import 'package:agripal/datamanage/datamanage.dart';
import 'package:agripal/values/fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../common_widgets/common_widgets.dart';
import '../plant_disease_prediction/disease_report_page.dart';
import '../plant_disease_prediction/predict_disease.dart';
import '../values/asset_values.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';


class PlantDiseaseReportHome extends StatefulWidget {
  @override
  _PlantDiseaseReportHomeState createState() => _PlantDiseaseReportHomeState();
}

class _PlantDiseaseReportHomeState extends State<PlantDiseaseReportHome>{


  var stream=DataManage.ref.snapshots();



  void getFullReport(File image,BuildContext context)async{


        var response = await PredictPlantDisease.uploadImageToServer(image);

       
          
          Navigator.pop(context);

          if(response!=null && response!="Error"){
            
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ReportPage(image: image,contents: response,floatingButton: false,)));

         }else{
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Error occured')));
          }
        

  }

  Future<File> _fileFromImageUrl(String imageUrl) async {
    
    final response = await http.get(Uri.parse(imageUrl));

    final documentDirectory = await getApplicationDocumentsDirectory();

    final file = File(join(documentDirectory.path, 'plant_image.jpg'));

    file.writeAsBytesSync(response.bodyBytes);

    return file;
  }


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text("Plant Disease Report",style: font4,),
        
      ),
      body: StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String,dynamic>>>snapshot) {
          if(snapshot.hasData){

            if(snapshot.data!['savedDiseasePredictions'].isEmpty){
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
              itemCount: snapshot.data!['savedDiseasePredictions'].length,
              itemBuilder: (context, index) {
                
                var item=snapshot.data!['savedDiseasePredictions'][index];

                return Container(
                  height: 150.h,
                  width: MediaQuery.of(context).size.width*0.5,
                  margin: EdgeInsets.symmetric(vertical: 15.h,horizontal: 20.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade500,
                        blurRadius: 5,
                        offset: Offset(0, 3)
                      )
                    ]
                  ),
                
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 150.h,
                        width: 130.w,
                        decoration: BoxDecoration(
                          
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r),bottomLeft: Radius.circular(10.r)),
                          image: DecorationImage(
                            image: NetworkImage(item['imageUrl']),
                            fit: BoxFit.cover
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              spreadRadius: 3,
                              offset: Offset(0, 3)
                            )
                          ]
                        )
                      ),
                      SizedBox(width: 10.w,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 160.w,
                                height: 20.h,
                                child: Text(
                                        "Name: ${item['plantName']}",
                                        style: font6,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,)),
                              Divider(height: 3.h,),
                              Container(
                                width: 160.w,
                                height: 20.h,
                                child: Text(
                                        "Condition: ${item['diseaseName']}",
                                        style: font6,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,)),
                              Divider(height: 3.h,),
                              Container(
                                width: 160.w,
                                height: 30.h,
                                child: Text(
                                        "Date: ${DateFormat.yMMMMd().format(DateTime.parse(item['time']))} ",
                                        style: font6,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,)),
                              // Divider(height: 3.h,),
                             
                
                            ],
                          ),
                           Padding(
                             padding: EdgeInsets.only(left: 50.w),
                             child: TextButton.icon(icon: Icon(Icons.arrow_forward_rounded,size: 18,), label: Text("View Full Report",style: font3,),
                              onPressed: ()async{

                                dialogBox(context, plant_loading,false);
                                  var file=await _fileFromImageUrl(item['imageUrl']);

                                  if(file==null){
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(content: Text('Error occured')));
                                  }
                                  else{
                                      getFullReport(file,context);
                                  }
                               }  
                                 
                             ),
                           )
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }
          else{
            
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