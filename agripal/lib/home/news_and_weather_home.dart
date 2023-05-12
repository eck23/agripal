import 'package:agripal/common_widgets/common_widgets.dart';
import 'package:agripal/news/getnews.dart';
import 'package:agripal/values/asset_values.dart';
import 'package:agripal/values/fonts.dart';
import 'package:agripal/weather/get_weather.dart';
import 'package:agripal/weather/weather_list.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../datamanage/datamanage.dart';
import '../news/news_container.dart';
import '../weather/weather_conatiner.dart';
import '../weather/weather_model.dart';

class NewsAndWeatherHome extends StatefulWidget {
  @override
  _NewsAndWeatherHomeState createState() => _NewsAndWeatherHomeState();
}

class _NewsAndWeatherHomeState extends State<NewsAndWeatherHome> {

  Color weatherColor=Colors.blueAccent.shade700;
  String backgroudImage="assets/images/night.jpg";
  List carouselElemets=[];
  List<Weather> weatherList=[];
  
  var locationStream=DataManage.ref.snapshots();


  @override
  Widget build(BuildContext context) {


      //Weather forecast container
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
            Padding(
              padding: EdgeInsets.only(top: 30.h,bottom: 10.h),
              child: StreamBuilder(
                stream: locationStream,

                builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String,dynamic>>> snapshot) {
                  if(snapshot.hasData ){
                     
                    print(snapshot.data);
                    
              
                     return FutureBuilder(
                       future: GetWeather.getWeatherFromList(snapshot.data!['weatherLocations']),
                       builder:((context, AsyncSnapshot<dynamic> snapshot) {
                          if(snapshot.hasData){
                            carouselElemets.clear();
                             for(var item in snapshot.data!){
                      
                               carouselElemets.add(WeatherContainer(currentWeather:item , canNavigate: true));
                             } 
                            carouselElemets.add(addLocationContainer());
                            carouselElemets.add(adsContainer());
                            weatherList=snapshot.data!;
                            return carouselSlider();
                        }else{
    
                           return  carouselSlider();
                        }

                
                       }));    
                  
                  }else{
                    carouselElemets.clear();
                    carouselElemets.add(addLocationContainer());
                    carouselElemets.add(adsContainer());
                    return carouselSlider();
                  }
                }),
             ),
            

            Padding(
                    padding:  EdgeInsets.only(top: 10.h,right: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: (){
                           weatherList.isNotEmpty?
                           Navigator.push(context, MaterialPageRoute(builder: ((context) => WeatherListUI(weatherList: weatherList,)))):
                           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Locations Added")));
                        } , 
                        child: Text("More on Weather",style: GoogleFonts.josefinSans(fontSize: 15.sp),)),
                        Icon(Icons.arrow_forward,size: 15.sp,color: Colors.blue,)
                      ],
                    ),
              ),
            

            Padding(
              padding: EdgeInsets.only(top: 12.h,left: 20.w,bottom: 20.h),
              child: Text("Stay Updated",style: font5,),
            ),
            //ElevatedButton(onPressed: () =>GetNews.getNews() , child: Text("get news"))

            FutureBuilder(
              future: GetNews.getNews(),

              builder: ((context, AsyncSnapshot<dynamic>  snapshot) {
                
                if(snapshot.hasData){

                  print("future builder");
                  return Container(
                    height: MediaQuery.of(context).size.height*0.4,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      addAutomaticKeepAlives: true,
                      itemCount: snapshot.data.articles.length,
                      itemBuilder: (context, index) {
                        return NewsConatiner(news: snapshot.data.articles[index],);
                      },
                    ),
                  );
                }else{
                  return Center(child:Container(
                    height: 70.h,
                    width: 70.w,
                    child: Lottie.asset("assets/lottie/news_loading.json",fit: BoxFit.contain)) );
                }
            
            }))
            ],
          ),
        );
  }


  addLocationContainer(){
      return InkWell(
        onTap: ()async{
          
            dialogBox(context, weather_loading,true);

            var result = await GetWeather.setWeatherLocation();
            // ignore: use_build_context_synchronously
            Navigator.pop(context);

            if(result=="ok") {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Location Added")));
            } else {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error in Adding Location")));
            }
        },
        child: Container(
            height: MediaQuery.of(context).size.height*0.2,
            width: MediaQuery.of(context).size.width*0.9,
            decoration: BoxDecoration(
              color: Colors.amberAccent.shade400,
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 2,
                  spreadRadius: 1,
                  offset: Offset(0.0, 2.0),
                )
              ],
            ),
          child: Center(
            child: DefaultTextStyle(
              style: GoogleFonts.pottaOne(fontSize: 25.sp,color: Colors.white,fontWeight: FontWeight.bold),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  WavyAnimatedText("tap to"),
                  ScaleAnimatedText('ADD LOCATIONS'),
                  WavyAnimatedText("tap to"),
                  ScaleAnimatedText('KNOW WEATHER'),
                  WavyAnimatedText("tap to"),
                  ScaleAnimatedText('STAY UPDATED'),
                ],
                onTap: () {
                  print("Tap Event");
                },
              ),
            ),
          ),
        ),
      );
  }

  adsContainer(){
      return Container(
          height: MediaQuery.of(context).size.height*0.2,
          width: MediaQuery.of(context).size.width*0.9,
          decoration: BoxDecoration(
            color: Colors.blue.shade900,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(0.0, 2.0),
              )
            ],
          ),
        child: Center(
          child: DefaultTextStyle(
            style: GoogleFonts.pottaOne(fontSize: 25.sp,color: Colors.white,fontWeight: FontWeight.bold),
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                
                ScaleAnimatedText('Powered By'),
                RotateAnimatedText("Flutter"),
                RotateAnimatedText("Firebase"),
                RotateAnimatedText("News API"),
                RotateAnimatedText("Open Meteo API"),
              ],
              onTap: () {
                print("Tap Event");
              },
            ),
          ),
        ),
      );
  }

   carouselSlider(){
    return  CarouselSlider(
              items: carouselElemets.map((items){
              return Builder(
                builder: (BuildContext){
                      return items;
                    });
                  }).toList(),
              key: UniqueKey(),
              options: CarouselOptions(
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              viewportFraction: 0.85,
              aspectRatio: 2.0,
              initialPage: 0 ,
              pauseAutoPlayOnTouch: true,
              autoPlayInterval: const Duration(seconds: 15),
              //autoPlayAnimationDuration: Duration(seconds: 2),
              autoPlay:true,),
                                         
          );
  }
}