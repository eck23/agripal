import 'package:agripal/values/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lottie/lottie.dart';

dialogBox(BuildContext context,String asset,bool adjustSize) {
    showDialog(
      barrierDismissible: false,
      builder: (ctx) {
        return Center(
          child:adjustSize? Container(
            height: MediaQuery.of(context).size.height*0.5,
            width: MediaQuery.of(context).size.width*0.5,
            child: Lottie.asset(asset)):Lottie.asset(asset),
        );
      },
      context: context,
    );
  }

confirmDialog(BuildContext context,String content,Function function) {
    showDialog(
      barrierDismissible: false,

      builder: (context) {
        return Center(
          child: Container(
            height: MediaQuery.of(context).size.height*0.25,
            width: MediaQuery.of(context).size.width*0.65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  spreadRadius: 3,
                  // offset: Offset(0, 2)
                )]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20.h,),
                Text(content,style: font9,),
                Divider(thickness: 0,),
                TextButton(onPressed:(){
                  Navigator.pop(context);
                  function();
                } , child: Text("Yes",style: font9,)),
                Divider(thickness: 0,),
                TextButton(onPressed: () =>Navigator.pop(context), child: Text("No",style: font9,)),

              ],
            ),
          ),
        );
      },
      context: context,
    );
}

