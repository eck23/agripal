import 'package:agripal/auth/auth.dart';
import 'package:agripal/home/news_and_weather_home.dart';
import 'package:agripal/values/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  int currentIndex=0;

  
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
          IconButton(onPressed: ()=>AuthMethods.signOut(), icon: const Icon(Icons.logout))],
      ),

      body: NewsAndWeatherHome(),

      bottomNavigationBar: BottomNavigationBar(
      currentIndex: currentIndex ,

      onTap: (index){
        setState(() {
          currentIndex=index;
        });
      },
      fixedColor:Colors.red.shade900,
      unselectedItemColor: Colors.blue.shade900,

      items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.newspaper),
        label: 'News',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.agriculture_rounded),
        label: 'Crop Care',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.history),
        label: 'Reports',
      ),
    ],
  ),
    );
  }
}