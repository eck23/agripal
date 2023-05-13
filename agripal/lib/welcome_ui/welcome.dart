import 'package:agripal/login/login_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatelessWidget {



  static  TextStyle goldcoinGreyStyle = TextStyle(
      color: Colors.grey.shade800,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      fontFamily: "LexendDeca");

  static  TextStyle goldCoinWhiteStyle = TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      fontFamily: "LexendDeca");
  static  TextStyle goldCoinBlackStyle = TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      fontFamily: "LexendDeca");

  static TextStyle greyStyle =
      TextStyle(fontSize: 40.0, color: Colors.grey.shade800, fontFamily: "LexendDeca");

  static  TextStyle whiteStyle =
      TextStyle(fontSize: 40.0, color: Colors.white, fontFamily: "LexendDeca");

  static  TextStyle blueStyle = TextStyle(
      fontSize: 40.0, color: Color(0xff404040), fontFamily: "LexendDeca");

  static  TextStyle boldStyle = TextStyle(
    fontSize: 50.0,
    color: Colors.black,
    fontFamily: "LexendDeca",
    fontWeight: FontWeight.bold,
  );

  static TextStyle descriptionGreyStyle = TextStyle(
    color: Colors.grey.shade800,
    fontSize: 20.0,
    fontFamily: "LexendDeca",
  );

  static const TextStyle descriptionWhiteStyle = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontFamily: "LexendDeca",
  );

  static const TextStyle descriptionBlueStyle = TextStyle(
    color: Color(0xff404040),
    fontSize: 20.0,
    fontFamily: "LexendDeca",
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LiquidSwipe(
          pages: [
            Container(
              color: Color(0xffb6e4f8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Image.asset("assets/images/agripal_logo.png") ,
                              // backgroundImage: AssetImage("assets/agripal_logo.png"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Agripal",
                                style: goldCoinBlackStyle,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text(
                            "Login",
                            style: goldCoinBlackStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 100.0.h,
                  // ),
                  Center(
                    child: Lottie.asset("assets/lottie/harvest.json",
                        width: 300, fit: BoxFit.fill),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Best Suiting",
                          style: greyStyle,
                        ),
                        Text(
                          "Crop",
                          style: boldStyle,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "Find the best\n"
                          "suited crop,\n"
                          "with our AI Engine",
                          style: descriptionGreyStyle,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Color(0xffefefef),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Image.asset("assets/images/agripal_logo.png") ,
                              //backgroundImage: AssetImage("assets/agripal_logo.png"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Agripal",
                                style: goldcoinGreyStyle,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text(
                            "Login",
                            style: goldcoinGreyStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                  Lottie.asset("assets/lottie/watering_plants.json"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Plant Disease",
                          style: blueStyle,
                        ),
                        Text(
                          "Prediction",
                          style: boldStyle,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "Grow your plant\n"
                          "healthy with our\n"
                          "Disease Prediction AI",
                          style: descriptionBlueStyle,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.amber,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Image.asset("assets/images/agripal_logo.png"),
                              //backgroundImage: AssetImage("assets/agripal_logo.png"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Agripal",
                                style: goldCoinWhiteStyle,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text(
                            "Login",
                            style: goldCoinWhiteStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                  Lottie.asset("assets/lottie/news_feed.json"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Stay",
                          style: whiteStyle,
                        ),
                        Text(
                          "Updated",
                          style: boldStyle,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "Don't miss the\n"
                          "agriculture trends\n"
                          "with our news feed",
                          style: descriptionWhiteStyle,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
          enableLoop: true,
          fullTransitionValue: 300,
          // enableSlideIcon: true,
          waveType: WaveType.liquidReveal,
          positionSlideIcon: 0.5,
        ),
      ),
    );
  }
}
