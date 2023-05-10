import 'package:agripal/auth/auth.dart';
import 'package:agripal/crop_recommend/crop_rec.dart';
import 'package:agripal/home/news_and_weather_home.dart';
import 'package:agripal/plant_disease_prediction/plant_disease.dart';
import 'package:agripal/values/fonts.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  int currentIndex=0;

  List<IconData> iconList=[
    Icons.newspaper,
    Icons.nature,
    Icons.agriculture,
    Icons.person
    ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset("assets/images/agripal_logo.png",height: 50,width: 50,),
            Text("Agripal",style: GoogleFonts.dancingScript(fontSize: 20.sp,color: Colors.black) ,)
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(onPressed: ()=>AuthMethods.signOut(), icon: const Icon(Icons.logout,color: Colors.black,))],
      ),

      body: IndexedStack(
        index: currentIndex,
        children: [
          NewsAndWeatherHome(),
          PlantDisease(),
          CropRecommend()
        ],
      ),
      
  bottomNavigationBar: AnimatedBottomNavigationBar(
      icons: iconList,
      activeColor: Colors.amber,
      inactiveColor: Colors.white,
      activeIndex: currentIndex,
      gapLocation: GapLocation.center,
      // leftCornerRadius: 50.r,
      // rightCornerRadius: 50.r,
      elevation: 5,
      notchSmoothness: NotchSmoothness.softEdge,
      backgroundColor: Colors.grey.shade900,
      gapWidth: 0,
      onTap: (index) => setState(() => currentIndex = index),
      //other params
   ),
  //     bottomNavigationBar: BottomNavigationBar(
  //     currentIndex: currentIndex ,

  //     onTap: (index){
  //       setState(() {
  //         currentIndex=index;
  //       });
  //     },
  //     fixedColor:Colors.red.shade900,
  //     unselectedItemColor: Colors.blue.shade900,
            
  //     items: const <BottomNavigationBarItem>[
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.newspaper),
  //       label: 'News',
  //     ),
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.nature),
  //       label: 'Plant Disease',
  //     ),
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.agriculture),
  //       label: 'Best Crop',
  //     ),
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.person),
  //       label: 'Profile',
  //     ),
  //   ],
  // ),
   floatingActionButton: FloatingActionButton(
      onPressed: null,
      child: Icon(iconList[currentIndex]),
      backgroundColor: Colors.amber.shade900,
      
    ),
   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}