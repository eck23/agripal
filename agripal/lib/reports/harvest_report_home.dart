import 'package:flutter/material.dart';

class HarvestReportHome extends StatefulWidget {
  @override
  _HarvestReportHomeState createState() => _HarvestReportHomeState();
}

class _HarvestReportHomeState extends State<HarvestReportHome>{

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Harvest Report"),
      ),
      body: Center(
        child: Text("Harvest Report"),
      ),
    );
  }
  
}