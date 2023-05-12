import 'package:agripal/reports/crop_rec_report_home.dart';
import 'package:agripal/values/fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'harvest_report_home.dart';
import 'plant_disease_report_home.dart';

class ReportsHome extends StatefulWidget {
  @override
  _ReportsHomeState createState() => _ReportsHomeState();
}

class _ReportsHomeState extends State<ReportsHome> {



  void pushPlantDiseaseReport(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>PlantDiseaseReportHome()));
  }

  void pushCropRecommendationReport(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>CropRecommendReportHome()));
  }

  void pushHarvestReport(){
     
     Navigator.push(context, MaterialPageRoute(builder: (context)=>HarvestReportHome()));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Reports",style: font7,),
            SizedBox(height: 20,),

            reportNavContainer("Plant Disease Report",Colors.amberAccent,pushPlantDiseaseReport),
            SizedBox(height: 20,),
            reportNavContainer("Crop Recommendation Report",Colors.redAccent,pushCropRecommendationReport),
            SizedBox(height: 20,),
            reportNavContainer("Harvest Report",Colors.green.shade400,pushHarvestReport),
          ],
        ),
      ),
    );
  }

  
  reportNavContainer(String title,Color color,Function onTap){

      return Container(
       height: MediaQuery.of(context).size.height*0.25,
       width: MediaQuery.of(context).size.width*0.9,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 60.h),
              child: Text(title,style: font8,),
            ),
            Padding(
              padding:EdgeInsets.only(top: 45.h,right: 20.w),
              child: InkWell(
                onTap: ()=>onTap(),
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("View Report",style: GoogleFonts.josefinSans(fontSize: 15.sp,color: Colors.white),),
                    Icon(Icons.arrow_forward_sharp,color: Colors.white,)
                  ],
                ),
              ),
            )
          ],
        ),
      );
  }

}