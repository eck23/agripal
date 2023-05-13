import 'dart:convert';
import 'dart:io';

import 'package:agripal/values/private.dart';
import 'package:http/http.dart' as http;

class PredictPlantDisease{


    static uploadImageToServer(File image) async {
          
          String url="http://$localIP:$port1/disease_detection";

         try{

                final request= http.MultipartRequest('POST', Uri.parse(url));

                final headers={
                  'Content-Type':'multipart/form-data'
                };
                

                request.files.add(http.MultipartFile.fromBytes('image',image.readAsBytesSync(),filename: image.path.split('/').last));

                request.headers.addAll(headers);
                
                var response= await request.send();
                print("hey guys");
                http.Response res=await http.Response.fromStream(response);
                 
                
                if(response.statusCode==200){
              
                  print('Image Uploaded ${res.body}');

                  return jsonDecode(res.body);

                } 
                else{
                  print('Image Not Uploaded');
                  return "Error";
                }
      
         }catch(e){
           print(e);
           return "Error";
         }
  }
}