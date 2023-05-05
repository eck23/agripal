import 'package:agripal/home/homescreen.dart';
import 'package:agripal/welcome_ui/welcome.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';


class SplashScreen extends StatefulWidget{


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
   navigateToScreen();
    
  }

  

  void navigateToScreen()async{

      await Future.delayed(const Duration(seconds: 4));
       // ignore: use_build_context_synchronously
       Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ControlScreen()),
          );
  }

  @override
  Widget build(BuildContext context) {
     
     return Scaffold(
        backgroundColor: Colors.amberAccent.shade700,
         body: SizedBox(
           height: MediaQuery.of(context).size.height,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
         
               Padding(
                 padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3),
                 child: Column(
                   
                   children: [
                     Material(
                         elevation: 20,
                         color: Colors.white,
                         shape:  const CircleBorder(side: BorderSide.none),
                         child: Image.asset("assets/images/agripal_logo.png",height: 200.h,width: 200.w,)),
         
                         SizedBox(height: 20.h,),
                         AnimatedTextKit(animatedTexts: [
                         TypewriterAnimatedText("A PAGE Group Concern",textStyle: GoogleFonts.poppins(fontSize: 15.sp,fontWeight: FontWeight.w600,color: Colors.black),),
                         // TypewriterAnimatedText("Agriculture at your fingertips",textStyle: GoogleFonts.poppins(fontSize: 15.sp,fontWeight: FontWeight.w600,color: Colors.black),),
                         ])
                   ],
                 ),
               ),
             
             Container(
                 
                 child: Lottie.asset("assets/lottie/grass.json",height: 120.h,width:double.infinity , animate: true,fit: BoxFit.fill,),
               ),
         
             ],
           ),
         ) ,
     );
  }
}


class ControlScreen extends StatefulWidget {
  const ControlScreen({Key? key}) : super(key: key);

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context,snapshot){
      
      
      if(snapshot.hasData && snapshot.connectionState == ConnectionState.active){
        return HomeScreen() ;
      }else{
        return WelcomeScreen();
      }
    });
  }
}