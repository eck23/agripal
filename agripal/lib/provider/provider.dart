import 'package:flutter/foundation.dart';

class WeatherButtonProvider extends ChangeNotifier {

  bool isWeatherLoaded=false;

  void setWeatherLoaded(bool value){
    isWeatherLoaded=value;
    notifyListeners();
  }
}
