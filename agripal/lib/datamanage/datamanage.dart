import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class DataManage{


  static updateWeatherLocation(Map<String,dynamic> location) async{

      try{
        await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.email).update({
          'weatherLocations':FieldValue.arrayUnion([location])
        });

        // await FirebaseFirestore.instance.collection("users").doc("elsonck").update({
        //   'weatherLocations':FieldValue.arrayUnion([location])
        // });
        return "ok";
      }on FirebaseException catch(e){
        return "Error";
      }

    }


}