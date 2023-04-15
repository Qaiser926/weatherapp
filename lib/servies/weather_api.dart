import 'package:wheather_app/consts/strings.dart';
import 'package:http/http.dart' as http;
import 'package:wheather_app/model/current_weather_model.dart';
import 'package:wheather_app/model/day_weather_model.dart';



getWeatherData(lat,long)async{
  var link="https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey&units=metric";
  var res=await http.get(Uri.parse(link));
  if(res.statusCode==200){
    var data=weatherModelClassFromJson(res.body.toString());
    print(data);
    return data;
  }
}

getDayWeatherData(lat,long)async{
  var linkDay="https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$long&appid=$apiKey";
  var res=await http.get(Uri.parse(linkDay));
  if(res.statusCode==200){
    var data=weatherDayModelClassFromJson(res.body.toString());
    print(data);
    return data;
  }
}