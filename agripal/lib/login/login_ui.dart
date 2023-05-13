import 'package:agripal/welcome_ui/splash.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../auth/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage>{

  bool isLogin=true;  //variable to check if user is logging in or signing up
  bool visible=true;  //variable to control AnimatedOpacity widget

  //form key for validation
  final _formKey = GlobalKey<FormState>();

  //Text Editing Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();



//function to clear text controllers
clearControllers(){
  emailController.clear();
  passwordController.clear();
  confirmPasswordController.clear();
  nameController.clear();
}

//function to submit form
onSubmitClick() async{

    String email=emailController.text.trim();
    String password=passwordController.text.trim();
    String confirmPassword=confirmPasswordController.text.trim();
    String name=nameController.text.trim();

    FocusScope.of(context).unfocus();

    if(!_formKey.currentState!.validate()){
      
      return;
    }

    if(!isLogin){

      if(password!=confirmPassword){
        
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password and Confirm Password do not match")));
        return;
      }

    }

    loading();
    
    var result= !isLogin? await AuthMethods.emailSignUp(email, password,name):await AuthMethods.emailSignIn(email, password);
                            
    // ignore: use_build_context_synchronously

     // ignore: unrelated_type_equality_checks

    await Future.delayed(const Duration(seconds: 1),(){
            Navigator.pop(context);
          });
      
     if(result== "Error"){

           
                
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("An error occured")));
            return;
     }
      

      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ControlScreen()));

   
}


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        
        body: SingleChildScrollView(
          child: Stack(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 270.h,
                    width: 400.w,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(500,200)),
                      image: DecorationImage(
                        image: AssetImage("assets/images/farmer.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
          
                   SizedBox(
                    width: double.infinity,
                    child: Lottie.asset("assets/lottie/grass.json",height: 180.h,width:double.infinity ,repeat: true ,animate: true,fit: BoxFit.fill,),
                ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: isLogin?45.h:70.h),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height *0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      SizedBox(height: 30.h,),
                      //Login or Register Container
                      Form(
                        key: _formKey,
                        child: AnimatedContainer(
                          height: isLogin?400.h:450.h,
                          width: 300.w,
                          duration: const Duration(seconds: 2),
                          curve: Curves.fastLinearToSlowEaseIn,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5),blurRadius: 10,spreadRadius: 2)],
                           
                          ),
                                
                          child: AnimatedOpacity(
                            opacity: visible?1:0.0,
                            duration: const Duration(seconds: 3),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                
                               if(isLogin) SizedBox(
                                  width: 100.w,
                                  height: 100.h,
                                 child: Lottie.asset("assets/lottie/login_icon.json",repeat: false,fit: BoxFit.contain,)),
                              
                              if(!isLogin) SizedBox(height: 30.h,),
                                Text(isLogin? "Login":"Register",style: GoogleFonts.aBeeZee(color: Colors.black,fontSize: 30.sp,fontWeight: FontWeight.bold),),
                                
                                SizedBox(height: 20.h,),
                                
                                fieldContainer("Enter Email",emailController,false),
                                
                                SizedBox(height: 20.h,),
                                
                                fieldContainer("Enter Password",passwordController,true),
                                
                                if(!isLogin) SizedBox(height: 20.h,),
                                
                                if(!isLogin) fieldContainer("Confirm Password",confirmPasswordController,true),
                                
                                if(!isLogin) SizedBox(height: 20.h,),
                                
                                if(!isLogin) fieldContainer("Enter Name",nameController,false),
                                
                                SizedBox(height: 20.h,),
                            
                                AnimatedButton(
                                  width: 180.w,
                                  text: "Submit",
                                  color: Colors.amber.shade400,
                                  height: 15.h,
                                  borderRadius: BorderRadius.circular(5.r),
                                  pressEvent:()=>onSubmitClick()),
                            
                               ],
                            
                            ),
                          ) ,
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      
                      //OR Text
                      AnimatedOpacity(
                        opacity: visible?1:0.0,
                        duration: const Duration(milliseconds: 500),
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
                  
                     SizedBox(height: 10.h,),
    
                      // Login- Register swithcer
                      AnimatedOpacity(
                        opacity: visible?1:0.0,
                        duration: const Duration(milliseconds: 500),
                        child: TextButton(child: Text(isLogin?"Register if you are new":"Login if you already have an account",style: GoogleFonts.josefinSans(color: Colors.orange.shade900,fontSize: 15.sp,fontWeight: FontWeight.w700)), onPressed: () {
                              
                              clearControllers();
                              FocusScope.of(context).unfocus();

                              setState(() {
                                visible=!visible;
                                
                              });
                        
                            Future.delayed( Duration(milliseconds: 500), () {
                                  setState(() {
                                    isLogin=!isLogin;
                                     visible=!visible;
                                    
                                });
                            });
                        
                    
                            
                        },),
                        ), 
                  
                      
                    ],
                  ),
                ),
              ),
            ),
            
          ],),
        )
        
      ),
    );
  }

  
  Widget fieldContainer(String labelText,TextEditingController controller,bool obscureText){

    return AnimatedOpacity(
      opacity: visible? 1.0:0.0,
      duration: const Duration(seconds: 1),
      child: Material(
        
        elevation: 20,
        child: Container(
         
          width: 250.w,
          height: 50.h,
          padding: EdgeInsets.all(10.w),
          
          child: TextFormField(
          
          controller: controller,
          obscureText: obscureText,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: labelText,    
            hintStyle: GoogleFonts.josefinSans(color: Colors.black,fontSize: 15.sp,fontWeight: FontWeight.bold),      
            border: InputBorder.none,
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter some value';
            }
            return null;
          
          },
          )
        ),
      ),
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