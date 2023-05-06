import 'package:agripal/auth/auth.dart';
import 'package:agripal/home/news_and_weather_home.dart';
import 'package:agripal/weather/weather_ui.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: Text("Agripal"),
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