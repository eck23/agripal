import 'dart:io';

import 'package:agripal/plant_disease_prediction/predict_disease.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import 'report_page.dart';

class PlantDisease extends StatefulWidget {
  @override
  _PlantDiseaseState createState() => _PlantDiseaseState();
}

class _PlantDiseaseState extends State<PlantDisease>{

   File? image;

  
  uploadImage()async{

        
        Navigator.pop(context);
        loading();

        var response = await PredictPlantDisease.uploadImageToServer(image!);

        await Future.delayed(const Duration(seconds: 2),(){
          
          Navigator.pop(context);
          if(response!=null && response!="Error"){
            
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ReportPage(image: image!,contents: response,)));

        }else{
            
            ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Error occured')));
          }
        });

      
        

  }

  onCancel(){
    image=null;
    Navigator.pop(context);
  }
  
 
  Future pickImage({required bool capture})async{

      try{
        final image =await ImagePicker().pickImage(source: capture?ImageSource.camera :ImageSource.gallery);

        if(image==null)return;

        final imageTemporary = File(image.path);

        // setState(() {
        //   this.image=imageTemporary;
        // });

        this.image=imageTemporary;

        showImage();

      }on PlatformException catch(e){
        print('Failed to pick image: $e');
      }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber.shade300,
        shadowColor: Colors.black,
        elevation: 10,
        title: Text('Plant Disease Detection',style: GoogleFonts.dancingScript(color: Colors.black,fontSize: 25.sp,fontWeight: FontWeight.bold),),

      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
              Container(width: double.infinity,height: 350.h,
                child: Center(
                  child: Lottie.asset('assets/lottie/swinging_plant.json',height: 200.h,width: 200.w,fit: BoxFit.fill),
                ),
              
              ),
            
          button(text: "Use Camera", icon: Icons.camera_alt_outlined,color: Colors.greenAccent.shade700,height: 30.h,width: 200.w,fontsize: 15.sp,radius: 25.r,function:()=>pickImage(capture: true)),

          Padding(
            padding: EdgeInsets.only(top: 20.h,bottom: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                Container(height: 1.h,width: 50.w,color: Colors.black26,),
                Padding(
                  padding: EdgeInsets.only(left: 15.w,right: 15.w),
                  child: Text("or",style: GoogleFonts.roboto(color: Colors.black,fontSize: 15.sp,fontWeight: FontWeight.w300),),
                ),
                Container(height: 1.h,width: 50.w,color: Colors.black26,),
              ],
            ),
          ),

           button(text: "Upload from Device", icon: Icons.upload,color: Colors.greenAccent.shade700,height: 30.h,width: 200.w,fontsize: 15.sp,radius: 25.r,function:()=>pickImage(capture: false)),
          ]
        ),
      )
    );
  }



  Widget button({required String text,IconData? icon,required Color color,required double height,required double width,required double fontsize,required double radius,required Function function}){
    return Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(25.r),
            elevation: 10,
            shadowColor: Colors.black,
            child: AnimatedButton(
                          text: text,
                          color:color,
                          height: height,
                          width: width,
                          icon: icon,
                          buttonTextStyle: GoogleFonts.roboto(color: Colors.white,fontSize: fontsize,fontWeight: FontWeight.bold),
                          borderRadius: BorderRadius.circular(radius),
                          pressEvent: ()=>function(),
              ),
          );
  }

  showImage() {
    showDialog(
      barrierDismissible: false,
      builder: (ctx) {
        return Center(
          child: Container(
            height: 320.h,
            width: 300.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: Colors.white60,
              boxShadow: const[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(0, 3)
                )
              ]
            ),
            child: Column(
              children: [
                Container(
                  height: 250.h,
                  width: 300.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight:Radius.circular(20.r),topLeft: Radius.circular(20.r)),
                    image: DecorationImage(
                      image: FileImage(image!),
                      fit: BoxFit.fill
                    )
                  )
                ),
                
                SizedBox(height: 10.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    button(text: "Cancel", icon:null,color: Colors.red,height: 0.h,width: 70.w,fontsize: 10.sp,radius: 20.r,function: ()=>onCancel()),
                    SizedBox(width: 10.w,),
                    button(text: "Predict", icon:null,color: Colors.green.shade400,height: 0.h,width: 70.w,fontsize: 10.sp,radius: 20.r,function: ()=>uploadImage()),
                  ],
                )
              ],
            ),
          )
        );
      },
      context: context,
    );
  }


loading() {
    showDialog(
      barrierDismissible: false,
      builder: (ctx) {
        return Center(
          child: Lottie.asset('assets/lottie/plant_anim.json'),
        );
      },
      context: context,
    );
  }
}