import 'dart:async';
import 'package:agripal/values/fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../common_widgets/common_widgets.dart';
import '../datamanage/datamanage.dart';
import '../values/asset_values.dart';
import '../values/private.dart';
import 'get_crop.dart';

class CropRecommend extends StatefulWidget{
  const CropRecommend({super.key});


  @override
  State<CropRecommend> createState() => _CropRecommendState();
}

class _CropRecommendState extends State<CropRecommend> {

  TextEditingController nitrogen = TextEditingController();
  TextEditingController phosphorus = TextEditingController();
  TextEditingController potassium = TextEditingController();
  TextEditingController ph = TextEditingController();
  TextEditingController rainfall = TextEditingController();
  TextEditingController humidity = TextEditingController();
  TextEditingController temperature = TextEditingController();
  
  var textVal=const TextEditingValue(text: "0.0");
  @override
  void initState() {
    
    nitrogen.value=textVal;
    phosphorus.value=textVal;
    potassium.value=textVal;
    ph.value=textVal;
    rainfall.value=textVal;
    humidity.value=textVal;
    temperature.value=textVal;


    super.initState();
  }

 final formKey = GlobalKey<FormState>();
 late Timer timer;
 bool timerEnabled=false;
var response;




callGetCrop() async{

   if(!isLocalHost){
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Feature not available in the web - Enable Local Host')));
            return;
    }

  response=null;
  FocusScope.of(context).unfocus();

  if (formKey.currentState!.validate()) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Processing Data')));
  
  
   dialogBox(context,plant_loading,false);

    response = await  GetCrop.findCrop(
    nitrogen: double.parse(nitrogen.text),
    phosphorus: double.parse(phosphorus.text),
    potassium: double.parse(potassium.text),
    ph: double.parse(ph.text),
    rainfall: double.parse(rainfall.text),
    humidity: double.parse(humidity.text),
    temperature: double.parse(temperature.text));
   
   
   
    
      
      Navigator.pop(context);

      if(response!=null && response!="Error") {
        
        showDialogBox();
      }
      else{
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error occured')));
      }
    

    
  }
}

void saveReport()async{

  //for loading dialog
  dialogBox(context,upload,true);

    var result= await DataManage.saveCropRecommendation({
      'nitrogen': double.parse(nitrogen.text),
      'phosphorus': double.parse(phosphorus.text),
      'potassium': double.parse(potassium.text),
      'ph': double.parse(ph.text),
      'rainfall': double.parse(rainfall.text),
      'humidity': double.parse(humidity.text),
      'temperature': double.parse(temperature.text),
      'crop': response['crop'],
      'time': DateTime.now().toString()
  });

  

  Navigator.pop(context);

  

  if(result=="ok"){
    dialogBox(context, done, false);

    
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pop(context);
      });
      clearAll();

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Report Saved')));
  
  }
  else{
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error occured')));
  }
}

clearAll(){
  nitrogen.value=textVal;
  phosphorus.value=textVal;
  potassium.value=textVal;
  ph.value=textVal;
  rainfall.value=textVal;
  humidity.value=textVal;
  temperature.value=textVal;
}



  @override
  Widget build(BuildContext context) {
      return GestureDetector(
        onTap: ()=>FocusScope.of(context).requestFocus(new FocusNode()),
        child:
        // Scaffold(
        //   appBar: AppBar(
        //     backgroundColor: Colors.white,
        //     elevation: 0,
        //     centerTitle: true,
        //     // shadowColor: Colors.orange.shade500,
        //     title:Text('Crop Recommendation',style: GoogleFonts.dancingScript(color: Colors.black,fontSize: 25.sp,fontWeight: FontWeight.bold),),
        //   ),
        //   backgroundColor: Colors.white,
        //   body:
            Form(
              key: formKey,
              child: Container(
                height: MediaQuery.of(context).size.height *0.8,
                width: MediaQuery.of(context).size.width ,
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.width *0.05, 
                                        bottom: MediaQuery.of(context).size.width *0.05,
                                        left: MediaQuery.of(context).size.width *0.07, 
                                        right: MediaQuery.of(context).size.width *0.07),
                
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Crop Recommendation',style: font7,),
                      SizedBox(height: 20.h),
                      fieldContainer("Enter Nitrogen",nitrogen),
                      fieldContainer("Enter Phosphorus",phosphorus),
                      fieldContainer("Enter Potassium",potassium),
                      fieldContainer("Enter Temperature",temperature),
                      fieldContainer("Enter Humidity",humidity),
                      fieldContainer("Enter pH",ph),
                      fieldContainer("Enter Rainfall",rainfall),
                      
                      
                     
                      // ElevatedButton(
                      //   onPressed: ()=>callGetCrop(),
                      //   child: const Text('Find Suitable Crop'),
                      // ),
                      SizedBox(height: 20.h),
                      AnimatedButton(
                        text: 'Find Suitable Crop',
                        color: Colors.greenAccent.shade700,
                        height: 20.h,
                        width: 220.w,
                        icon: Icons.nature,
                        buttonTextStyle: GoogleFonts.roboto(color: Colors.white,fontSize: 15.sp,fontWeight: FontWeight.bold),
                        borderRadius: BorderRadius.circular(15.r),
                        pressEvent: ()=>callGetCrop(),
                      )
                
                    ],
                          ),
                ),
              )
                  )
      //  ),
      );
  }

  Widget fieldContainer(String labelText,TextEditingController controller){

    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Container(
       
        width: MediaQuery.of(context).size.width *0.9,
        height: MediaQuery.of(context).size.height *0.1,

        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width *0.6,
              child: TextFormField(
              
              controller: controller,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}')),
              ],
              decoration: InputDecoration(
                
                border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                label: Text(labelText)
              ),
              validator: (value) {
                if ( value==null || value.isEmpty ||double.parse(value)==0.0) {
                  return 'Please enter some value';
                }
                return null;
              
              },
          ),
            ),
          
           IconButton(onPressed: ()=>controller.value=TextEditingValue(text: (double.parse(controller.text)-0.1).toStringAsFixed(1)), icon: Icon(Icons.remove)),
           IconButton(onPressed: ()=>controller.value=TextEditingValue(text: (double.parse(controller.text)+0.1).toStringAsFixed(1)), icon: Icon(Icons.add))
          ]
        )
      ),
    );
  }


  showDialogBox(){
    var width=MediaQuery.of(context).size.width ;
    var height=MediaQuery.of(context).size.height ;
     return AwesomeDialog(
                      context: context,
                      dialogType: DialogType.info,
                      borderSide: const BorderSide(
                        color: Colors.green,
                        width: 3,
                      ),
                      customHeader: Lottie.asset('assets/lottie/mob_plant.json',height:height,width: width),
                      width: 350.w ,
                      buttonsBorderRadius: BorderRadius.all(
                        Radius.circular(20.r),
                      ),
                      dismissOnTouchOutside: true,
                      dismissOnBackKeyPress: false,
                      // onDismissCallback: (type) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       content: Text('Dismissed by $type'),
                      //     ),
                      //   );
                      // },
                      headerAnimationLoop: false,
                      animType: AnimType.scale,
                      descTextStyle: GoogleFonts.roboto(color: Colors.black87,fontSize: 16.sp,fontWeight: FontWeight.w400),
                      title: 'Crop Recommendation',
                      desc: 'We recommend you to grow ${response['crop']}',
                      // showCloseIcon: true,
                      btnCancelText: "Cancel",
                      btnOkText: "Save Report",
                      btnCancelOnPress: (){},
                      btnOkOnPress: ()=>saveReport(),
                    ).show();
  }

 

}