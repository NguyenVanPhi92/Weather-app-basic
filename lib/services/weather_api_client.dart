// to start call some http request in flultter we will need the fultter http package
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app1/model/weather_model.dart';

class WeatherApiClient{
  Future<Weather>? getCurrentWeather(String? location) async{
    var endpoint = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location&appid=171e0d7f9de4950ee24c637a19706120&units=metric");
    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    print(Weather.fromJSON(body).cityName);
    return Weather.fromJSON(body);
  }
}