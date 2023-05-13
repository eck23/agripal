import 'dart:convert';

import 'package:agripal/values/private.dart';
import 'package:http/http.dart' as http;

class GetCrop {

   
  static findCrop({double nitrogen=0.0, double phosphorus=0.0, double potassium=0.0, double ph=0.0, double rainfall=0.0, double humidity=0.0, double temperature=0.0}) async {
    
   
    String url = "http://$localIP:$port2/crop_recommend?N=$nitrogen&P=$phosphorus&K=$potassium&temp=$temperature&humidity=$humidity&ph=$ph&rainfall=$rainfall" ;

    try {

      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {

        return jsonDecode(response.body);

      } else {

        return "Error";
      }
    } catch (e) {

      return "Error";
    }
  }
}