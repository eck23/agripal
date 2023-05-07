import 'package:agripal/home/homescreen.dart';
import 'package:agripal/provider/provider.dart';
import 'package:agripal/welcome_ui/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';



void main() async{

  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(const Agripal());
}

class Agripal extends StatelessWidget {
  const Agripal({super.key});

  @override
  Widget build(BuildContext context) {

   return  ScreenUtilInit(
      minTextAdapt: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => WeatherButtonProvider()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Agripal',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: HomeScreen(),
          ),
        );
      },
    );
  }
}


