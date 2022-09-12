import 'dart:convert';
import 'dart:developer';

import 'package:apis/main.dart';
import 'package:apis/modules/current%20weather/model/current_weather_model.dart';
import 'package:apis/modules/sevenday%20forcaste/model/seven_day_forcast_model.dart';
import 'package:apis/data/tour.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;

class LocalStorage {
  bool isForcasteAvailable =
      sharedPreferences.getBool("isForcasteAvailable") ?? false;
  bool isWeatherAvailable =
      sharedPreferences.getBool("isWeatherAvailable") ?? false;
  saveAppData() {
    if (isForcasteAvailable && isWeatherAvailable) {
      // do nothing
    } else {
      _saveAllWeatherData();
      _saveAllForcastData();
    }
  }

//---------------------------------------------------------------------------------------------->
  static Future<SevenDayForcastModel> geyForcastFromStorage(
      Tour tourDetail) async {
    var _dataFromStorage =
        sharedPreferences.getString("forcast-${tourDetail.city}");

    return SevenDayForcastModel.fromJson(jsonDecode(_dataFromStorage!));
  }

//---------------------------------------------------------------------------------------------->
  static Future<CurrentWeatherModel> getCityWeatherFromStorage(
      String cityName) async {
    var dataFromStorage = sharedPreferences.getString("weather-$cityName");

    return CurrentWeatherModel.fromJson(jsonDecode(dataFromStorage!));
  }

//---------------------------------------------------------------------------------------------->
  void _saveAllForcastData() async {
    String accessToken = dotenv.env['API_KEY']!;
    if (await InternetConnectionChecker().hasConnection) {
      for (Tour tour in allTours) {
        final response = await http.get(Uri.parse(
            "https://api.openweathermap.org/data/2.5/onecall?lat=${tour.latLon["lat"]}&lon=${tour.latLon["lon"]}&exclude=hourly,minutely,current&appid=$accessToken"));

        if (response.statusCode == 200) {
          //update database
          await sharedPreferences.setString(
              "forcast-${tour.city}", response.body);
        } else {
          inspect("failed to update ${tour.city} ");
          Fluttertoast.showToast(msg: "Failed to update cities forcaste");
        }
      }
      //// set true so we dont need to load from everytime we fetch data from the API

      await sharedPreferences.setBool("isForcasteAvailable", true);
    } else {
      Fluttertoast.showToast(
          msg: "Try again with an active internet Connection");
    }
  }

//---------------------------------------------------------------------------------------------->
  void _saveAllWeatherData() async {
    String accessToken = dotenv.env['API_KEY']!;
    if (await InternetConnectionChecker().hasConnection) {
      for (Tour tour in allTours) {
        final response = await http.get(Uri.parse(
            "https://api.openweathermap.org/data/2.5/weather?q=${tour.city}&appid=$accessToken"));

        if (response.statusCode == 200) {
          //update database
          await sharedPreferences.setString(
              "weather-${tour.city}", response.body);
        } else {
          inspect("failed to update ${tour.city} ");
          Fluttertoast.showToast(msg: "Failed to update cities forcaste");
        }
      }
      await sharedPreferences.setBool("isWeatherAvailable", true);
    } else {
      Fluttertoast.showToast(
          msg: "Try again with an active internet Connection");
    }
  }
}
