import 'package:agripal/values/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'news_model.dart';

class NewsConatiner extends StatelessWidget {

  late News news;

  NewsConatiner({required this.news});

  @override
  Widget build(BuildContext context) {

    print(news.title);
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
             height: 80.h,
             width: MediaQuery.of(context).size.width*0.2,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10.r),
               boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 3), // changes position of shadow
                ),],
               image: DecorationImage(
                 image: NetworkImage(news.urlToImage),
                 fit: BoxFit.fill
               )
             ),
          ) ,
          SizedBox(width: 10.w,),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.6,
            child: Text(
              news.title,
              softWrap: true,
              maxLines: 3,
              textAlign: TextAlign.justify,

              style: font6,
            ),
          )
        ],
      ),
    );
  }
}