import 'package:agripal/datamanage/datamanage.dart';
import 'package:agripal/news/getnews.dart';
import 'package:agripal/values/fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import '../news/news_container.dart';
import '../weather/get_location.dart';
import '../weather/weather_conatiner.dart';

class NewsAndWeatherHome extends StatefulWidget {
  @override
  _NewsAndWeatherHomeState createState() => _NewsAndWeatherHomeState();
}

class _NewsAndWeatherHomeState extends State<NewsAndWeatherHome> {

  bool locationIsSet=false;

  Color weatherColor=Colors.blueAccent.shade700;
  String backgroudImage="assets/images/night.jpg";
  List carouselElemets=[];
  
  var locationStream=FirebaseFirestore.instance.collection("users").doc("elsonck").snapshots();
  
  // setWeather()async{

  //     var result= await GetWeather.setWeather();

      
  //     if(result!=null){
        
  //       setState(() {
  //         locationIsSet=true;
  //         carouselElemets.clear();
  //         carouselElemets.add(WeatherContainer(currentWeather: result['currentWeather'], placename: placename, canNavigate: true,));
  //         carouselElemets.add(addLocationContainer());
  //         carouselElemets.addAll(sevenDaysWeather.sevenDaysWeather.map((weather) => WeatherContainer(placename: placename, currentWeather: weather,)));
  //       });
  //     }

  // }


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

                builder: (context, snapshot) {
                  if(snapshot.hasData){
                     
                    // print("hi hi hi hi");
                    carouselElemets.clear();
                     for(var item in snapshot.data!['weatherLocations']){
                      
                       carouselElemets.add(WeatherContainer(lat:item['lat'] ,long: item['long'], canNavigate: true));
                     } 
                      carouselElemets.add(addLocationContainer());
              
                     return CarouselSlider(items: carouselElemets.map((items){
                        return Builder(builder: (BuildContext){
                          return items;
                        });
                      }).toList(),
                    key: UniqueKey(),
                    options: CarouselOptions(
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    viewportFraction: 0.85,
                    aspectRatio: 2.0,
                    initialPage: 1,
                    //autoPlayAnimationDuration: Duration(seconds: 2),
                    autoPlay:false,),
                    );
                  }else{
                    return addLocationContainer();
                  }

                  
                }
              ),
             ),
            
            
            SizedBox(height: 5.h,),

            Padding(
              padding: EdgeInsets.all(20.w),
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
      return Container(
          height: MediaQuery.of(context).size.height*0.2,
          width: MediaQuery.of(context).size.width*0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.black,width: 2),
            // image: DecorationImage(
            //   image: AssetImage(backgroudImage),
              
            //   fit: BoxFit.cover,
            // ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 2,
                spreadRadius: 1,
                // offset: Offset(0.0, 2.0),
              )
            ],
          ),
        child: Center(
          child: IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: ()async{
                 Position positon= await GetLocation.determinePosition();
                 List<Placemark> placemarks = await placemarkFromCoordinates(positon.latitude, positon.longitude);
                 print("Lat :${placemarks[0].locality}, Long :${placemarks[0].country},");
                 DataManage.updateWeatherLocation({'lat':positon.latitude,'long':positon.longitude,'placename':placemarks[0].locality});
            },
            icon: Icon(Icons.add_location_alt_rounded,size: 50.w,color: Colors.blueAccent.shade700,),
          )
        ),
      );
  }
}