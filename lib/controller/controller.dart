import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:wheather_app/servies/weather_api.dart';

class ThemeController extends GetxController{
@override
  void onInit() async{
    // TODO: implemeant onInit
    super.onInit();
   await getUserLocation();
    currentWeatherData=getWeatherData(latitude.value,longitude.value);
    dayWeatherData=getDayWeatherData(latitude.value,longitude.value);

  }
  var isDart=false.obs;
  var currentWeatherData;
  var dayWeatherData;
  var latitude=0.0.obs;
  var longitude=0.0.obs;
  var  isLoading=false.obs;


  themeChange(){
    isDart.value=!isDart.value;
    Get.changeThemeMode(isDart.value?ThemeMode.dark:ThemeMode.light);
  }

  getUserLocation()async{
    var isLocationEnabled;
    var userPermission;
    isLocationEnabled=await Geolocator.isLocationServiceEnabled();
    if(!isLocationEnabled){
      return Future.error("Location is not Enabled");
    }
    userPermission=await Geolocator.checkPermission();
    if(userPermission==LocationPermission.deniedForever){
      return Future.error("Permission is denied forever");

    }else if (userPermission==LocationPermission.denied){
      userPermission=await Geolocator.requestPermission();
      if(userPermission==LocationPermission.denied){
        return Future.error("Permission is denied");
      }
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) {
      latitude.value=value.latitude;
      longitude.value=value.longitude;
      isLoading.value=true;
    });
  }

}