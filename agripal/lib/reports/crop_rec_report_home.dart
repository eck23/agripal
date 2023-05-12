import 'package:flutter/material.dart';

class CropRecommendReportHome extends StatefulWidget {
  @override
  _CropRecommendReportHomeState createState() => _CropRecommendReportHomeState();
}

class _CropRecommendReportHomeState extends State<CropRecommendReportHome>{

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crop Recommendation Report"),
      ),
      body: Center(
        child: Text("Crop Recommendation Report"),
      ),
    );
  }
  
}