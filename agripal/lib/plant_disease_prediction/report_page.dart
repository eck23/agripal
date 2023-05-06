import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportPage extends StatefulWidget {

File image;
 var contents;

  ReportPage({required this.image,required this.contents});
  


  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {

  String plantName="";
  String diseaseName="";
  String diseaseDescription="";
  String diseaseSolution="";

  
  @override
  void initState() {
    plantName=widget.contents['title'].substring(0,widget.contents['title'].indexOf(':'));
    diseaseName=widget.contents['title'].substring(widget.contents['title'].indexOf(':')+1);
    diseaseDescription=widget.contents['description'].replaceAll("\n", " ");
    diseaseSolution=widget.contents['prevent'].replaceAll("\n", " ");
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade400,
        title: Text('Report',style: GoogleFonts.dancingScript(color: Colors.black,fontSize: 25.sp,fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //PLANT IMAGE, NAME AND HEALTH STATUS SECTION

            Padding(
              padding: EdgeInsets.all(20.w),
              child: Container(
                height: 200.h,
                
                child: Row(
                  children: [
                      Container(
                        height: 170.h,
                        width: 140.w,
                        
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                          image: DecorationImage(
                            image: FileImage(widget.image),
                            fit: BoxFit.fill
                          )
                        )
                       
                      ),
                    Container(
                      height: 180.h,
                      padding: EdgeInsets.only(left: 15.w,top: 40.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxHeight: 100.h,
                              maxWidth: 140.w,
                
                            ),
                            child: Text(plantName,
                            softWrap: true,
                            style: GoogleFonts.roboto(color: Colors.black,fontSize: 25.sp,fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          
                          diseaseName.trim().compareTo("Healthy")==0 ?Icon(Icons.health_and_safety_outlined,color: Colors.green,size: 60.r,): 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.warning_amber_outlined,color: Colors.red,size: 30.r,),
                              Container(
                                padding: EdgeInsets.only(left: 3.w),
                                constraints: BoxConstraints(
                                maxHeight: 180.h,
                                maxWidth: 140.w,
                
                              ),
                                child: Text(diseaseName,
                                softWrap: true,
                                style: GoogleFonts.roboto(color: Colors.black,fontSize: 15.sp,fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            //DESCRIPTION SECTION
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Text('Description',style: GoogleFonts.roboto(color: Colors.black,fontSize: 20.sp,fontWeight: FontWeight.bold),),
            ),

            Padding(
              padding: EdgeInsets.only(left: 20.w,right: 20.w,top: 10.h,bottom: 20.h),
              child: Container(
                constraints: BoxConstraints(
                maxHeight: double.infinity,
                maxWidth: 300.w,
                
                ),
              child: 
                  Text(
                    diseaseDescription,
                    softWrap: true,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.roboto(color: Colors.black,fontSize: 15.sp,fontWeight: FontWeight.w300),
                  )
                ),
            ),

            //PREVENTIVE MEASURE SECTION
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Text('Preventive Measures',style: GoogleFonts.roboto(color: Colors.black,fontSize: 20.sp,fontWeight: FontWeight.bold),),
            ),

            Padding(
              padding: EdgeInsets.only(left: 20.w,right: 20.w,top: 10.h,bottom: 20.h),
              child: Container(
                constraints: BoxConstraints(
                maxHeight: double.infinity,
                maxWidth: 300.w,
                
                ),
              child: 
                  Text(
                    diseaseSolution,
                    softWrap: true,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.roboto(color: Colors.black,fontSize: 15.sp,fontWeight: FontWeight.w300),
                  )
                ),
            ),

            //SUPPLEMENT SECTION
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Text('Supplements',style: GoogleFonts.roboto(color: Colors.black,fontSize: 20.sp,fontWeight: FontWeight.bold),),
            ),

            Padding(
              padding: EdgeInsets.all(20.w),
              child: Container(
                height: 200.h,
                
                child: Row(
                  children: [
                      Container(
                        height: 170.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30.r)),
                          boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: Offset(0, 3), // changes position of shadow
                          ),],
                          image: DecorationImage(
                            image: NetworkImage(widget.contents['supplement_image_url']),
                            fit: BoxFit.fill
                          )
                        ),
                      
                      // child:Image.network(
                      //       widget.contents['supplement_image_url'],
                      //       fit: BoxFit.fill,
                      //       loadingBuilder: (BuildContext context, Widget child,
                      //           ImageChunkEvent? loadingProgress) {
                      //         if (loadingProgress == null) return child;
                      //         return Center(
                      //           child: CircularProgressIndicator(
                      //             value: loadingProgress.expectedTotalBytes != null
                      //                 ? loadingProgress.cumulativeBytesLoaded /
                      //                     loadingProgress.expectedTotalBytes!
                      //                 : null,
                      //           ),
                      //         );
                      //       },
                      //   ) ,
                    ),
                    Container(
                      height: 180.h,
                      padding: EdgeInsets.only(left: 15.w,top: 40.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxHeight: 100.h,
                              maxWidth: 140.w,
                
                            ),
                            child: Text(widget.contents['supplement_name'],
                            softWrap: true,
                            style: GoogleFonts.roboto(color: Colors.black,fontSize: 20.sp,fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          
                          Container(
                            constraints: BoxConstraints(
                              maxHeight: 40.h,
                              maxWidth: 100.w,
                
                            ),
                            child: AnimatedButton(
                              text: "Buy Now",
                              borderRadius: BorderRadius.all(Radius.circular(10.r)),
                              color: Colors.red,pressEvent: () {

                                  launchUrl(Uri.parse(widget.contents['supplement_buy_link']));

                            },),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
           
          ],
        ),
      )
    );
  }
}