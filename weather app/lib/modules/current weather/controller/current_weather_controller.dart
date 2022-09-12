import 'dart:convert';
import 'package:apis/data/local_database.dart';
import 'package:apis/main.dart';
import 'package:apis/data/tour.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:apis/modules/current%20weather/model/current_weather_model.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CurrentWeatherController extends GetxService {
  String accessToken = dotenv.env['API_KEY']!;
  Future<CurrentWeatherModel?> weatherData(Tour tourDetail) async {
    if (await InternetConnectionChecker().hasConnection) {
      return getCityDataFromAPI(tourDetail.city);
    } else if (LocalStorage().isForcasteAvailable &&
        LocalStorage().isWeatherAvailable) {
      return LocalStorage.getCityWeatherFromStorage(tourDetail.city);
    } else {
      return null;
    }
  }

  Future<CurrentWeatherModel> getCityDataFromAPI(String cityname) async {
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=$accessToken"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      await sharedPreferences.setString("weather-$cityname", response.body);
      return CurrentWeatherModel.fromJson(data);
    } else {
      throw Exception('Failed to load Daily Data');
    }
  }
}
