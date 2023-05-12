import 'dart:convert';

import 'package:http/http.dart' as http;

class GetCrop {

   
  static findCrop({double nitrogen=0.0, double phosphorus=0.0, double potassium=0.0, double ph=0.0, double rainfall=0.0, double humidity=0.0, double temperature=0.0}) async {
    
   
    String url = "http://10.0.2.2:8001/crop_recommend?N=$nitrogen&P=$phosphorus&K=$potassium&temp=$temperature&humidity=$humidity&ph=$ph&rainfall=$rainfall" ;

    try {
      print(url);
      var response = await http.get(Uri.parse(url));

    
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body);
      } else {
        return "Error";
      }
    } catch (e) {
      print(e);
      return "Error";
    }
  }
}