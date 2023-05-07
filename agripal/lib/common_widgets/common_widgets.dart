import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

loading(BuildContext context,String asset) {
    showDialog(
      barrierDismissible: false,
      builder: (ctx) {
        return Center(
          child: Container(
            height: 180.h,
            width: 180.w,
            child: Lottie.asset(asset)),
        );
      },
      context: context,
    );
  }