import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

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
  
  var textVal=const TextEditingValue(text: "0.00");
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

 final _formKey = GlobalKey<FormState>();
 late Timer timer;
 bool timerEnabled=false;
var response;




callGetCrop() async{

  response=null;
  
  if (_formKey.currentState!.validate()) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Processing Data')));
  
  
  loading();

    response = await  GetCrop.findCrop(
    nitrogen: double.parse(nitrogen.text),
    phosphorus: double.parse(phosphorus.text),
    potassium: double.parse(potassium.text),
    ph: double.parse(ph.text),
    rainfall: double.parse(rainfall.text),
    humidity: double.parse(humidity.text),
    temperature: double.parse(temperature.text));
   }
   
   
    Future.delayed(Duration(seconds: 2),(){
      
      Navigator.pop(context);

      if(response!=null && response!="Error") {
        
        showDialogBox();
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error occured')));
      }
    });
   
   
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
              key: _formKey,
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
                      Text('Crop Recommendation',style: GoogleFonts.dancingScript(color: Colors.black,fontSize: 25.sp,fontWeight: FontWeight.bold),),
                      SizedBox(height: 20.h),
                      fieldContainer("Enter Nitrogen",nitrogen),
                      fieldContainer("Enter Phosphorus",phosphorus),
                      fieldContainer("Enter Potassium",potassium),
                      fieldContainer("Enter PH",ph),
                      fieldContainer("Enter Rainfall",rainfall),
                      fieldContainer("Enter Humidity",humidity),
                      fieldContainer("Enter Temperature",temperature),
                     
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

    return Container(
     
      width: MediaQuery.of(context).size.width *0.9,
      height: MediaQuery.of(context).size.height *0.1,

      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width *0.6,
            child: TextFormField(
            
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: InputDecoration(
              
              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),),
              label: Text(labelText)
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some value';
              }
              return null;
            
            },
        ),
          ),
        
         IconButton(onPressed: ()=>controller.value=TextEditingValue(text: (double.parse(controller.text)-0.1).toStringAsFixed(2)), icon: Icon(Icons.remove)),
         IconButton(onPressed: ()=>controller.value=TextEditingValue(text: (double.parse(controller.text)+0.1).toStringAsFixed(2)), icon: Icon(Icons.add))
        ]
      )
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
                      // btnCancelOnPress: () {},
                      btnOkOnPress: () {},
                    ).show();
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