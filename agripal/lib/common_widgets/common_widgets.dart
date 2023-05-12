import 'package:flutter/material.dart';

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