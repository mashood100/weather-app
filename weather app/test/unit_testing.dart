import 'package:apis/data/tour.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  ///Testing For Local DataBase
  //------------------------------->
  group("Testing weather and forecast data in local Storage:", () {
    bool isForcasteAvailable =
        sharedPreferences.getBool("isForcasteAvailable") ?? false;
    bool isWeatherAvailable =
        sharedPreferences.getBool("isWeatherAvailable") ?? false;

    test("Forcaste data is available in local storage", () async {
      bool result = false;
      // check if the data is already load in the database or not
      if (isForcasteAvailable) {
        for (Tour tour in allTours) {
          String? dataFromStorage =
              sharedPreferences.getString("forcast-${tour.city}");
          result = dataFromStorage is String;
          expect(result, true,
              reason: "No Data Found For the City: ${tour.city}");
        }
      } else {
        expect(result, false);
      }
    });

//----------------------------------------------------------------------------------------------->

    test("Weather detail is available in local storage", () {
      bool result = false;
      // check if the data is already load in the database or not
      if (isWeatherAvailable) {
        for (Tour tour in allTours) {
          String? dataFromStorage =
              sharedPreferences.getString("weather-${tour.city}");
          result = dataFromStorage is String;
          expect(result, true, reason: "No Data Found For City ${tour.city}");
        }
      } else {
        expect(result, false);
      }
    });
  });
}
