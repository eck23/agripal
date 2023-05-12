import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';


class DataManage{
  
  static var ref;
  
  static updateWeatherLocation(Map<String,dynamic> location) async{

      try{
        await DataManage.ref.update({
          'weatherLocations':FieldValue.arrayUnion([location])
        }).timeout(Duration(seconds: 20),onTimeout: (() {
          return "Error";
        }));

        // await FirebaseFirestore.instance.collection("users").doc("elsonck").update({
        //   'weatherLocations':FieldValue.arrayUnion([location])
        // });
        return "ok";

      }on FirebaseException catch(e){

        return "Error";

      }

    }

   static saveCropRecommendation(Map<String,dynamic> data)async{

      try{
        await DataManage.ref.update({
          'savedCropRecommendations':FieldValue.arrayUnion([data])
        }).timeout(Duration(seconds: 20),onTimeout: (() {
          return "Error";
        }));

        return "ok";

      }on FirebaseException catch(e){

        return "Error";

      }

    }

          

    static savePlantDisease(File image,String plantName,String diseaseName)async{

        final String filePath = "${FirebaseAuth.instance.currentUser!.email}/disease/${image.path.split('/').last}";
        
        final ref= FirebaseStorage.instance.ref().child(filePath);

        bool timeout=false;

       try{

            var result= await ref.putFile(image).then((val){
          
            val.ref.getDownloadURL().then((val) async {
               
             await  DataManage.ref.update({
                      'savedDiseasePredictions':FieldValue.arrayUnion([{
                        'imageUrl':val,
                        'plantName':plantName,
                        'diseaseName':diseaseName,
                        'time':DateTime.now().toString()
                      }])
                    });

              });
              
            }).timeout(Duration(seconds: 20),onTimeout: (() {
               timeout=true;
            }));
            
            
            if(!timeout){
              return "ok";
            }
            else{
              return null;
            }

          }on FirebaseException catch(e){
              
              return null;

          }on Exception catch(e){
              
              return null;

          }
    } 


}