import 'package:agripal/values/private.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth/auth.dart';
import '../values/fonts.dart';

class SettingsHome extends StatefulWidget {
  @override
  _SettingsHomeState createState() => _SettingsHomeState();
}

bool isLocalHost=false;

class _SettingsHomeState extends State<SettingsHome>{

 

  TextEditingController ipController=TextEditingController();
  TextEditingController portController1=TextEditingController();
  TextEditingController portController2=TextEditingController();
  TextEditingController nameEditController=TextEditingController();

  bool confirmNameEdit=false;

  TextStyle style=GoogleFonts.josefinSans(fontSize: 15.sp, color: Colors.black,fontWeight: FontWeight.w600);
  TextStyle style2=GoogleFonts.josefinSans(fontSize: 15.sp, color: Colors.black,fontWeight: FontWeight.w300);

  @override
  void initState() {
    
    nameEditController.text=FirebaseAuth.instance.currentUser!.displayName!;
    super.initState();
  }
  

  //function to update the user display name
  void updateName()async{
    if(nameEditController.text.trim().isEmpty){
      
      nameEditController.text= FirebaseAuth.instance.currentUser!.displayName.toString();
      setState(() {
        confirmNameEdit=!confirmNameEdit;
      });
      return;   
    }

    await FirebaseAuth.instance.currentUser!.updateDisplayName(nameEditController.text.trim());

    nameEditController.text= FirebaseAuth.instance.currentUser!.displayName.toString();

    setState(() {
      confirmNameEdit=!confirmNameEdit;
      
    });
  }

  @override
  Widget build(BuildContext context) {
      
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
         backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
         title: Text("Settings",style: font7,),
       ),

       body: SingleChildScrollView(
         child: Center(
           child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              
              children: [
       
                  SizedBox(height: 20.h,),
                  CircleAvatar(
                    radius: 60.r,
                    child: Image.asset("assets/images/agripal_logo.png",height: 200.h,width: 200.w,),
                    backgroundColor: Colors.white,
                    ),
                    
                  
       
                  SizedBox(height: 10.h,),
       
       
                   Text("version 1.0.0",style:font3, ),
       
                    SizedBox(height: MediaQuery.of(context).size.height*0.1,),
       
                    //TextField to change the user display name
                    Container(
                      width: MediaQuery.of(context).size.width*0.9,
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        // border: Border.all(color: Colors.black),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            blurRadius: 5,
                            offset: Offset(0, 3)
                          )
                        ]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*0.6,
                            
                            child: TextField(
                              controller: nameEditController,
                              style: style,
                              enabled: confirmNameEdit,
                              decoration: InputDecoration(
                                hintText: "Change Display Name",
                                hintStyle: style2,
                                border: InputBorder.none
                                
                              ),
                            ),
                          ),
       
                          SizedBox(width: 10.w,),
                          !confirmNameEdit? IconButton(onPressed: (){
                            setState(() {
                              confirmNameEdit=!confirmNameEdit;
                            });
                          }, icon: const Icon(Icons.edit,color: Colors.black,)):

                          IconButton(onPressed: ()async{

                            updateName();
                            
                          }, icon: const Icon(Icons.check,color: Colors.black,))
                        ],
                      ),
                    ),
       
                    //switch button to enable and diasable locahost ip and port number
                    SizedBox(height: 20.h,),  
                    Container(
                      width: MediaQuery.of(context).size.width*0.9,
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        // border: Border.all(color: Colors.black),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            blurRadius: 5,
                            offset: Offset(0, 3)
                          )
                        ]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Localhost  (For Test)",style: style,),
                          Switch(
                              value:isLocalHost , 
                              onChanged: (value){
                                setState(() {
                                  isLocalHost=value;
                                  if(isLocalHost==true){
                                    _showDialog();
                                  }
                                  else{
                                    ipController.clear();
                                    portController1.clear();
                                    portController2.clear();
                                  }
                                });
                              },
                        
                            activeColor: Colors.amber,
                          )
                        ],
                      ),
                      
                    ),
                    
                    SizedBox(height: MediaQuery.of(context).size.height*0.2,),
       
                    //logout button
                    Container(
                      width: MediaQuery.of(context).size.width*0.5,
       
                      child: AnimatedButton(pressEvent: (){
                        AuthMethods.signOut();
                      }, text: "Logout", color: Colors.redAccent, icon: Icons.logout,),
                    ),
              ],
           ),
         ),
       ),
    ); 
  }


  // alert box with textfield to enter ip and port number
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter IP and Port Number'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: ipController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter IP"
                ),
              ),

               TextField(
                controller: portController1,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Port Number(Disease Prediction)"
                ),
              ),

               TextField(
                controller: portController2,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Port Number(Crop Recommendation)"
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                ipController.clear();
                portController1.clear();
                portController2.clear();
                localIP="";
                port1="";
                port2="";
                isLocalHost=false;
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                
                if(ipController.text.trim().isEmpty || portController1.text.trim().isEmpty || portController2.text.trim().isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Enter IP and Port Number"),));
                  return;
                }else{
                  localIP=ipController.text.trim();
                  port1=portController1.text.trim();
                  port2=portController2.text.trim();
                  Navigator.of(context).pop();
                }

                
              },
            ),
          ],
        );
      },
    );
  }
}