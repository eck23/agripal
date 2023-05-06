import 'dart:convert';

import 'package:agripal/news/news_model.dart';
import 'package:agripal/private_data/privatedata.dart';
import 'package:http/http.dart' as http;

class GetNews{

  static getNews()async{
    print("Getting news");

    String todate= DateTime.now().toString().split(" ")[0].toString();
    String fromdate= DateTime.now().subtract(Duration(days: 3)).toString().split(" ")[0].toString();
    

    String url="https://newsapi.org/v2/everything?q=farming&from=$fromdate&to=$todate&sortBy=popularity&apiKey=$newsApiKey";


     try{
       var reponse = await http.get(Uri.parse(url));  

        if(reponse.statusCode!=200){
          print("Failed");
          return null;
        }
        // print(reponse.body);

        Articles articles=Articles();

        var data=jsonDecode(reponse.body);
        
        // print(data["articles"].length());

        print("hello");
        for(int i=0;i<data["articles"].length;i++){
          print("in for loop");
          articles.articles.add(
            News(
              title: data["articles"][i]["title"] ?? "", 
              description: data["articles"][i]["description"] ?? "", 
              url: data["articles"][i]["url"] ?? "", 
              urlToImage: data["articles"][i]["urlToImage"] ?? "", 
              publishedAt: data["articles"][i]["publishedAt"] ?? "", 
              content: data["articles"][i]["content"] ?? ""
              ));

        }

      

        return articles;
        

     }catch(e){
       return null;
     }  
  }
}