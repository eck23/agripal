import 'package:agripal/common_widgets/common_widgets.dart';
import 'package:agripal/values/asset_values.dart';
import 'package:agripal/values/private.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/auth.dart';
import '../values/fonts.dart';

class SettingsHome extends StatefulWidget {
  @override
  _SettingsHomeState createState() => _SettingsHomeState();
}


class _SettingsHomeState extends State<SettingsHome>{

 

  TextEditingController ipController=TextEditingController();
  TextEditingController portController1=TextEditingController();
  TextEditingController portController2=TextEditingController();
  TextEditingController nameEditController=TextEditingController();

  FocusNode nameFocus = FocusNode();

  bool confirmNameEdit=false;
  bool showIpInfo=false;

  TextStyle style=GoogleFonts.josefinSans(fontSize: 15.sp, color: Colors.black,fontWeight: FontWeight.w600);
  TextStyle style2=GoogleFonts.josefinSans(fontSize: 15.sp, color: Colors.black,fontWeight: FontWeight.w300);

  @override
  void initState() {
    
    nameEditController.text=FirebaseAuth.instance.currentUser!.displayName!;
    super.initState();
  }
  

  //function to update the user display name
  void updateName()async{
    if(nameEditController.text.trim().isEmpty || nameEditController.text.trim()==FirebaseAuth.instance.currentUser!.displayName.toString()){
      
      nameEditController.text= FirebaseAuth.instance.currentUser!.displayName.toString();
      setState(() {
        confirmNameEdit=!confirmNameEdit;
      });
      return;   
    }

    dialogBox(context, plant_loading, false);

    await FirebaseAuth.instance.currentUser!.updateDisplayName(nameEditController.text.trim()).timeout(Duration(seconds: 20), onTimeout: () {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error occured"),));
      return;
    });
    
    nameEditController.text= FirebaseAuth.instance.currentUser!.displayName.toString();

    Navigator.pop(context);

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              
              children: [
       
                  SizedBox(height: 20.h,),
                  CircleAvatar(
                    radius: 60.r,
                    child: Image.asset("assets/images/agripal_logo.png",height: 200.h,width: 200.w,),
                    backgroundColor: Colors.white,
                    ),
                    
                  
       
                  SizedBox(height: 5.h,),
       
       
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
                              focusNode: nameFocus,
                              style: style,
                              // enabled: confirmNameEdit,
                              readOnly: !confirmNameEdit,
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
                              FocusScope.of(context).requestFocus(nameFocus);
                            });

                            

                          }, icon: const Icon(Icons.edit,color: Colors.black,)):

                          IconButton(onPressed: ()async{
                            FocusScope.of(context).unfocus();

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
                          Row(
                            children: [
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
                                        showIpInfo=false;
                                        setIPandPortVal();
                                      }
                                    });
                                  },
                        
                                activeColor: Colors.amber,
                              ),

                              //icon button to display the ip and port number
                              IconButton(onPressed: (){
                                if(isLocalHost){
                                  setState(() {
                                  showIpInfo=!showIpInfo;
                                });
                                }
                              }, icon: Icon(!showIpInfo? Icons.keyboard_arrow_down_outlined:Icons.keyboard_arrow_up_outlined,color: Colors.black,))
                            ],
                          )
                        ],
                      ),
                      
                    ),

                    //Animated container which displays the ip and port number if localhost is enabled
                    SizedBox(height: 5.h),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                      height: isLocalHost&&showIpInfo ?MediaQuery.of(context).size.height*0.3:0,
                      width: MediaQuery.of(context).size.width*0.9,
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: Colors.white),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            blurRadius: 5,
                            offset: Offset(0, 3)
                          )
                        ]
                        ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("IP: $localIP",style: style,),
                          Text("Port (Disease Prediction): $port1",style: style,),
                          Text("Port (Crop Recommendation): $port2",style: style,),
                        ],
                      ),
                    ),
                    
                    
                    SizedBox(height: 200.h),
       
                    //logout button
                    Container(
                      width: MediaQuery.of(context).size.width*0.5,
       
                      child: AnimatedButton(pressEvent:(){
                        confirmDialog(context,"Sure to Logout?", ()=>AuthMethods.signOut());
                        Navigator.pop(context);
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

    getIPandPortVal();

    ipController.text=localIP;
    portController1.text=port1;
    portController2.text=port2;

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
                  hintText: "Port (Disease Prediction)"
                ),
              ),

               TextField(
                controller: portController2,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Port (Crop Recommendation)"
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () async{
                
                ipController.clear();
                portController1.clear();
                portController2.clear();
                isLocalHost=false;
                showIpInfo=false;
                await setIPandPortVal();
                await getIPandPortVal();

                setState(() {
                
                  Navigator.of(context).pop();
                });
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () async{
                
                if(ipController.text.trim().isEmpty || portController1.text.trim().isEmpty || portController2.text.trim().isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Enter IP and Port Number"),));
                  return;
                }else{

                  localIP=ipController.text.trim();
                  port1=portController1.text.trim();
                  port2=portController2.text.trim();
                  isLocalHost=true;
                  await setIPandPortVal();
                  await getIPandPortVal();
                  setState(() {
                    Navigator.of(context).pop();
                  });
                  
                  
                }

                
              },
            ),
          ],
        );
      },
    );
  }
}


setIPandPortVal()async{
    // Obtain shared preferences.
   final SharedPreferences prefs = await SharedPreferences.getInstance();

   await  prefs.setString("ip", localIP);
   await  prefs.setString("port1", port1);
   await  prefs.setString("port2", port2);
   await  prefs.setBool("isLocalHost", isLocalHost);
  
  }

  getIPandPortVal()async{
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    localIP= prefs.getString("ip")!;
    port1=prefs.getString("port1")!;
    port2=prefs.getString("port2")!;
    isLocalHost=prefs.getBool("isLocalHost")!;
  }