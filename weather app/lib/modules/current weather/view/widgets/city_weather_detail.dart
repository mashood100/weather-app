import 'package:apis/constants/color_constant.dart';
import 'package:apis/constants/weather_icons.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CityWeatherDetail extends StatelessWidget {
  const CityWeatherDetail({Key? key, this.temperature, this.weatherType})
      : super(key: key);
  final num? temperature;
  final String? weatherType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 22),
      child: Row(
        children: [
          AutoSizeText(
            temperature == null
                ? "N/A"
                : (temperature! - 273.0).toStringAsFixed(0),
            style: TextStyle(
                fontWeight: FontWeight.w300,
                color: AppColors.myTextColor,
                fontSize: 52),
          ),
          const SizedBox(
            width: 7,
          ),
          AutoSizeText(
            "\u2103",
            style: TextStyle(
                fontWeight: FontWeight.w200,
                color: AppColors.myTextColor,
                fontSize: 52),
          ),
          const SizedBox(
            width: 12,
          ),
          WeatherIcon(
            weatherCondition: weatherType?.toLowerCase(),
          )
        ],
      ),
    );
  }
}

class WeatherIcon extends StatelessWidget {
  final String? weatherCondition;
  const WeatherIcon({Key? key, this.weatherCondition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (weatherCondition == "haze") {
      return _Icon(iconPath: WeatherIcons.hazeIcon);
    } else if (weatherCondition == "smoke") {
      return _Icon(iconPath: WeatherIcons.smokeIcon);
    } else if (weatherCondition == "mist") {
      return _Icon(iconPath: WeatherIcons.mistIcon);
    } else if (weatherCondition == "clear") {
      return _Icon(iconPath: WeatherIcons.clearIcon);
    } else if (weatherCondition == "clouds") {
      return _Icon(iconPath: WeatherIcons.cloudIcon);
    } else {
      return _Icon(iconPath: WeatherIcons.gernalIcon);
    }
  }
}

class _Icon extends StatelessWidget {
  final String iconPath;
  const _Icon({Key? key, required this.iconPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      iconPath,
      height: MediaQuery.of(context).size.height * 0.05,
      fit: BoxFit.cover,
    );
  }
}
